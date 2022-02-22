
from github import Github
# Github username
username = "mahahahajan"
# pygithub object
g = Github()
# get that user by username

f = open("gh_pages_repo.txt", "r+")
f.write("GH Repos with pages \n")

try: 
    user = g.get_user(username)
    for repo in user.get_repos():
        if repo.has_pages:
            print(f"https://{username}.github.io/{repo.name}/ \n")
            # print_repo(repo)
            f.write(repo.name + " \n")
            f.write(f"https://{username}.github.io/{repo.name}/ \n")
except:
    print(f.read())
f.close()

