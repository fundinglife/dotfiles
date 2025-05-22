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

async function githubFetch(url, options = {}) {
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
    const data = await response.json();
    debugLog(`[githubFetch] Response: ${JSON.stringify(data)}`);
    return data;
  } catch (e) {
    debugLog(`[githubFetch] Error: ${e}`);
    throw e;
  }
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
    orgs = await githubFetch("https://api.github.com/user/orgs");
  } catch (e) {
    debugLog(`[loadOrgs] Error fetching orgs: ${e}`);
    alert('Error fetching organizations. See debug console.');
    return;
  }
  debugLog(`[loadOrgs] Orgs: ${JSON.stringify(orgs)}`);
  const orgList = document.getElementById("orgList");
  orgList.innerHTML = "";
  for (const org of orgs) {
    debugLog(`[loadOrgs] Org login: ${org.login}`); // Added debug log for each org
    const container = document.createElement("div");
    container.innerHTML = `<h2>${org.login}</h2><ul id="repos-${org.login}"></ul>
      <form onsubmit="createRepo(event, '${org.login}')">
        <input type="text" placeholder="New repo name" name="reponame" required />
        <button type="submit">Create Repo</button>
      </form>`;
    orgList.appendChild(container);
    loadRepos(org.login);
  }
}

async function loadRepos(orgLogin) {
  debugLog(`[loadRepos] Org: ${orgLogin}`);
  let repos;
  try {
    repos = await githubFetch(`https://api.github.com/orgs/${orgLogin}/repos`);
  } catch (e) {
    debugLog(`[loadRepos] Error: ${e}`);
    return;
  }
  debugLog(`[loadRepos] Repos: ${JSON.stringify(repos)}`);
  const ul = document.getElementById(`repos-${orgLogin}`);
  ul.innerHTML = "";
  for (const repo of repos) {
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