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
    document.body.insertBefore(debugConsole, document.body.firstChild);
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

  // Load personal repos block and wait for it to finish before loading orgs
  const personalContainer = document.createElement("div");
  personalContainer.innerHTML = `<h2>Personal</h2><ul id="repos-personal"></ul>`;
  orgList.appendChild(personalContainer);
  await loadPersonalRepos();

  debugLog(`[loadOrgs] Finished loading personal repos`);

  for (const org of orgs) {
    debugLog(`[loadOrgs] Org login: ${org.login}`); // Added debug log for each org
    const container = document.createElement("div");
    container.innerHTML = `<h2>${org.login}</h2><ul id="repos-${org.login}"></ul>
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
  } catch (e) {
    debugLog(`[loadPersonalRepos] Error: ${e}`);
    return;
  }
  debugLog(`[loadPersonalRepos] Repos: ${JSON.stringify(repos)}`);
  const ul = document.getElementById("repos-personal");
  ul.innerHTML = "";
  for (const repo of repos) {
    debugLog(`[loadPersonalRepos] Repo: ${repo.name}`);
    const li = document.createElement("li");
    li.textContent = repo.name;
    ul.appendChild(li);
  }
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
  const ul = document.getElementById(`repos-${orgLogin}`);
  ul.innerHTML = "";
  for (const repo of repos) {
    debugLog(`[loadRepos] Repo: ${repo.name}`); // Added debug log for each repo
    const li = document.createElement("li");
    li.textContent = repo.name;
    ul.appendChild(li);
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