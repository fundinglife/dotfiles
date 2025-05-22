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
  const response = await fetch(url, { ...options, headers });
  return response.json();
}

async function loadOrgs() {
  token = document.getElementById("tokenInput").value.trim();
  if (!token) return alert("Please enter a GitHub token");

  const orgs = await githubFetch("https://api.github.com/user/orgs");

  const orgList = document.getElementById("orgList");
  orgList.innerHTML = "";

  for (const org of orgs) {
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
  const repos = await githubFetch(`https://api.github.com/orgs/${orgLogin}/repos`);
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
  if (!name) return;

  await githubFetch(`https://api.github.com/orgs/${orgLogin}/repos`, {
    method: "POST",
    body: JSON.stringify({ name }),
    headers: { "Content-Type": "application/json" },
  });

  loadRepos(orgLogin);
  input.value = "";
}