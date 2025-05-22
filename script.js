// Debug flag and virtual console
const DEBUG = true;
let debugConsole;
let _debugLogBuffer = [];
function debugLog(msg) {
  if (!DEBUG) return;
  if (!debugConsole) {
    _debugLogBuffer.push(msg);
    return;
  }
  // Flush buffer if needed
  if (_debugLogBuffer.length) {
    for (const m of _debugLogBuffer) debugConsole.textContent += (typeof m === 'string' ? m : JSON.stringify(m, null, 2)) + '\n';
    _debugLogBuffer = [];
  }
  debugConsole.textContent += (typeof msg === 'string' ? msg : JSON.stringify(msg, null, 2)) + '\n';
}
window.addEventListener('DOMContentLoaded', function() {
  if (DEBUG) {
    debugConsole = document.createElement('div');
    debugConsole.id = 'debugConsole';
    debugConsole.style = 'background:#222;color:#0f0;padding:8px;font-family:monospace;max-height:200px;overflow:auto;margin:8px 0;white-space:pre-wrap;';
    document.body.appendChild(debugConsole);
    debugLog('✅ Debug console enabled.');
  }
});
// Ensure the Load Orgs button works even if script is loaded in <head> or before DOM
window.addEventListener('DOMContentLoaded', function() {
  var btn = document.getElementById("loadOrgsBtn");
  if (btn) btn.onclick = loadOrgs;
});
document.body.insertAdjacentHTML("beforeend", "<p style='color:green;'>✅ script.js is working</p>");
let token = "";

async function githubFetch(url, options = {}, returnHeaders = false) {
  const headers = {
    Authorization: `token ${token}`,
    Accept: "application/vnd.github+json",
    ...options.headers,
  };
  debugLog(`[githubFetch] URL: ${url}`);
  debugLog(`[githubFetch] Options: ${JSON.stringify(options)}`);
  try {
    const response = await fetch(url, { ...options, headers });
    debugLog(`[githubFetch] Status: ${response.status}`);
    if (response.status === 204) {
      debugLog(`[githubFetch] No content returned (204)`);
      return [];
    }
    const data = await response.json();
    debugLog(`[githubFetch] Response: ${JSON.stringify(data)}`);
    if (returnHeaders) {
      return { data, headers: response.headers };
    }
    return data;
  } catch (e) {
    debugLog(`[githubFetch] Error: ${e}`);
    throw e;
  }
}

async function fetchAllPages(url) {
  let results = [];
  let nextUrl = url;
  while (nextUrl) {
    const { data, headers } = await githubFetch(nextUrl, {}, true);
    results = results.concat(data);
    const linkHeader = headers.get('link');
    if (linkHeader) {
      const links = {};
      linkHeader.split(',').forEach(part => {
        const section = part.split(';');
        if (section.length !== 2) return;
        const urlPart = section[0].trim().slice(1, -1);
        const namePart = section[1].trim().replace(/rel="(.*)"/, '$1');
        links[namePart] = urlPart;
      });
      nextUrl = links['next'] || null;
    } else {
      nextUrl = null;
    }
  }
  return results;
}

async function loadOrgs() {
  token = document.getElementById("tokenInput").value.trim();
  debugLog(`[loadOrgs] Token: ${token ? '[provided]' : '[empty]'}`);
  if (!token) {
    debugLog('[loadOrgs] No token entered.');
    alert("Please enter a GitHub token");
    return;
  }
  let orgs;
  try {
    orgs = await fetchAllPages("https://api.github.com/user/orgs?per_page=100");
  } catch (e) {
    debugLog(`[loadOrgs] Error fetching orgs: ${e}`);
    alert('Error fetching organizations. See debug console.');
    return;
  }
  debugLog(`[loadOrgs] Orgs: ${JSON.stringify(orgs)}`);
  const orgList = document.getElementById("orgList");
  orgList.innerHTML = "";

  // Load personal repos block with create form and wait for it to finish before loading orgs
  const personalContainer = document.createElement("div");
  personalContainer.className = "org-card";
  personalContainer.innerHTML = `
    <h2>Personal</h2>
    <div id="repos-personal" class="repo-list"></div>
    <form onsubmit="createPersonalRepo(event)">
      <input type="text" placeholder="New personal repo name" name="reponame" required />
      <button type="submit">Create Personal Repo</button>
    </form>
  `;
  orgList.appendChild(personalContainer);
  await loadPersonalRepos();

  debugLog(`[loadOrgs] Finished loading personal repos`);

  for (const org of orgs) {
    debugLog(`[loadOrgs] Org login: ${org.login}`); // Added debug log for each org
    const container = document.createElement("div");
    container.className = "org-card";
    container.innerHTML = `<h2>${org.login}</h2>
      <div id="repos-${org.login}" class="repo-list"></div>
      <form onsubmit="createRepo(event, '${org.login}')">
        <input type="text" placeholder="New repo name" name="reponame" required />
        <button type="submit">Create Repo</button>
      </form>`;
    orgList.appendChild(container);
    debugLog(`[loadOrgs] Appended container for org: ${org.login}`);

    // More debug logs for loadRepos
    debugLog(`[loadOrgs] Calling loadRepos for org: ${org.login}`);
    await loadRepos(org.login);
    debugLog(`[loadOrgs] Finished loading repos for org: ${org.login}`);

    // Additional debug logs for each repo in org
    debugLog(`[loadOrgs] Listing repos for org: ${org.login}`);
    const ul = document.getElementById(`repos-${org.login}`);
    if (!ul) {
      debugLog(`[loadOrgs] No ul element found for org: ${org.login}`);
    } else {
      debugLog(`[loadOrgs] ul element found for org: ${org.login}, children count: ${ul.children.length}`);
      for (const child of ul.children) {
        debugLog(`[loadOrgs] Repo list item: ${child.textContent}`);
      }
    }
  }
}

async function loadPersonalRepos() {
  debugLog('[loadPersonalRepos] Loading personal repositories');
  let repos;
  try {
    repos = await fetchAllPages("https://api.github.com/user/repos?per_page=100");
    debugLog(`[loadPersonalRepos] Fetched repos count: ${repos.length}`);
  } catch (e) {
    debugLog(`[loadPersonalRepos] Error: ${e}`);
    alert('Error loading personal repositories. See debug console.');
    return;
  }
  if (!repos || repos.length === 0) {
    debugLog('[loadPersonalRepos] No personal repositories found.');
  }
  debugLog(`[loadPersonalRepos] Repos: ${JSON.stringify(repos)}`);
  const container = document.getElementById("repos-personal");
  if (!container) {
    debugLog('[loadPersonalRepos] No element with id "repos-personal" found.');
    return;
  }
  container.innerHTML = "";
  container.className = "repo-list";
  for (const repo of repos) {
    debugLog(`[loadPersonalRepos] Repo: ${repo.name}`);
    const card = document.createElement("div");
    card.className = "repo-card";
    card.innerHTML = `
      <div class="repo-info">
        <h3>${repo.name}</h3>
        <p>${repo.description || "No description"}</p>
      </div>
      <div class="repo-middle"></div>
      <form class="repo-form" onsubmit="event.preventDefault();">
        <input type="text" placeholder="New name" name="reponame" />
        <button type="submit">Submit</button>
      </form>
    `;
    container.appendChild(card);
  }
  debugLog('[loadPersonalRepos] Finished updating UI with personal repos.');
}

async function loadRepos(orgLogin) {
  debugLog(`[loadRepos] Org: ${orgLogin}`);
  let repos;
  try {
    repos = await fetchAllPages(`https://api.github.com/orgs/${orgLogin}/repos?per_page=100`);
  } catch (e) {
    debugLog(`[loadRepos] Error: ${e}`);
    return;
  }
  debugLog(`[loadRepos] Repos: ${JSON.stringify(repos)}`);
  const container = document.getElementById(`repos-${orgLogin}`);
  container.innerHTML = "";
  container.className = "repo-list";
  for (const repo of repos) {
    debugLog(`[loadRepos] Appending repo: ${repo.name}`);
    const card = document.createElement("div");
    card.className = "repo-card";
    card.innerHTML = `
      <h3>${repo.name}</h3>
      <p>${repo.description || "No description"}</p>
      <div class="repo-stats">
        <span>⭐ ${repo.stargazers_count}</span>
        <span>🍴 ${repo.forks_count}</span>
      </div>
    `;
    container.appendChild(card);
    debugLog(`[loadRepos] Appended repo: ${repo.name}`);
  }
}

async function createRepo(event, orgLogin) {
  event.preventDefault();
  const input = event.target.reponame;
  const name = input.value.trim();
  debugLog(`[createRepo] Org: ${orgLogin}, Name: ${name}`);
  if (!name) {
    debugLog('[createRepo] No repo name entered.');
    return;
  }
  try {
    await githubFetch(`https://api.github.com/orgs/${orgLogin}/repos`, {
      method: "POST",
      body: JSON.stringify({ name }),
      headers: { "Content-Type": "application/json" },
    });
    debugLog('[createRepo] Repo created.');
  } catch (e) {
    debugLog(`[createRepo] Error: ${e}`);
    alert('Error creating repo. See debug console.');
    return;
  }
  loadRepos(orgLogin);
  input.value = "";
}
// On page load, check URL for token parameter and auto-fill input and load orgs if present
window.addEventListener('DOMContentLoaded', () => {
  const urlParams = new URLSearchParams(window.location.search);
  const tokenParam = urlParams.get('token');
  if (tokenParam) {
    const tokenInput = document.getElementById('tokenInput');
    if (tokenInput) {
      tokenInput.value = tokenParam;
      loadOrgs();
    }
  }
});

// Create personal repo function
async function createPersonalRepo(event) {
  event.preventDefault();
  const input = event.target.reponame;
  const name = input.value.trim();
  debugLog(`[createPersonalRepo] Name: ${name}`);
  if (!name) {
    debugLog('[createPersonalRepo] No repo name entered.');
    return;
  }
  try {
    await githubFetch(`https://api.github.com/user/repos`, {
      method: "POST",
      body: JSON.stringify({ name }),
      headers: { "Content-Type": "application/json" },
    });
    debugLog('[createPersonalRepo] Repo created.');
  } catch (e) {
    debugLog(`[createPersonalRepo] Error: ${e}`);
    alert('Error creating personal repo. See debug console.');
    return;
  }
  await loadPersonalRepos();
  input.value = "";
}
// Add debug logs inside loadPersonalRepos to verify data and errors
const originalLoadPersonalRepos = loadPersonalRepos;
loadPersonalRepos = async function() {
  try {
    const repos = await fetchAllPages("https://api.github.com/user/repos?per_page=100");
    debugLog(`[loadPersonalRepos] Fetched repos count: ${repos.length}`);
    return originalLoadPersonalRepos.apply(this, arguments);
  } catch (e) {
    debugLog(`[loadPersonalRepos] Error fetching repos: ${e}`);
    throw e;
  }
};