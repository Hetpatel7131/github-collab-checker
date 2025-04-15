# github-collab-checker

A simple Bash script to list all users who have **read access (pull permission)** to a specified GitHub repository. It uses GitHub's REST API and requires authentication via a personal access token.

---

## 🚀 Features

- Lists collaborators with **read access** to a public or private repository.
- Uses **GitHub's REST API**.
- Authenticates via your GitHub **username and personal access token (PAT)**.
- Easy to use from the command line.

---

## 🛠 Requirements

- `bash`
- `curl`
- [`jq`](https://stedolan.github.io/jq/) for parsing JSON
- GitHub **Personal Access Token** with `repo` scope (for private repos)

---

## 🔐 Setup

Before running the script, export your GitHub credentials as environment variables:

```bash
export USERNAME="your_github_username"
export TOKEN="your_personal_access_token"
```

> ⚠️ Keep your token secure and **never commit it** to any repository!

---

## 📦 Usage

```bash
./list-users.sh <repo_owner> <repo_name>
```

### ✅ Example

```bash
./list-users.sh Hetpatel7131 github-collab-checker
```

If successful, you'll see a list of GitHub usernames with read access to that repository.

---

## 🧪 Sample Output

```
🔍 Listing users with read access to Hetpatel7131/github-collab-checker...
Users with read access to Hetpatel7131/github-collab-checker:
octocat
janedoe
johnsmith
```

---

## ❌ Error Handling

If there’s an error (like an invalid token or repo name), you’ll get a helpful message, such as:

```
❌ Error fetching collaborators for Hetpatel7131/github-collab-checker:
Bad credentials
```

---
