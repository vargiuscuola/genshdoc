# genshdoc

GitHub Action to automatically generate on every git push the markdown documentation extracted with [vargiuscuola/shdoc](https://github.com/vargiuscuola/shdoc) from the shell scripts contained in the Github repository referencing this action.

## Usage

Create a script file for which you want to automate the generation of markdown documentation extracted from it: write your code and the related documentation in the format described in [vargiuscuola/shdoc](https://github.com/vargiuscuola/shdoc). Also add inside the script file the following comment:
```bash
#github-action genshdoc
```

You can add this comment anywhere in the script, probably better at the top of the file after the shebang line.
This comment line will act as a directive to inform `genshdoc` GitHub Action that we want documentation extracted from that file.

Then create a workflow referencing `vargiuscuola/genshdoc`.
For example, put in a workflow with path `.github/workflows/generate-documentation.yml` the following content:
```yaml
name: Generate Documentation

on: [push]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
    - name: Checkout
      uses: actions/checkout@v2
    - name: Github Action genshdoc
      id: action-genshdoc
      uses: vargiuscuola/genshdoc@master
    - name: genshdoc result
      run: echo "The result of genshdoc Action was ${{ steps.action-genshdoc.outputs.result }}"
    - name: Commit files
      run: |
        echo ${{ github.ref }}
        git add .
        git config --local user.email "action@github.com"
        git config --local user.name "GitHub Action"
        git commit -m "CI: Automated build push" -a | exit 0
    - name: Push changes
      if: github.ref == 'refs/heads/master'
      uses: ad-m/github-push-action@master
      with:
        github_token: ${{ secrets.GITHUB_TOKEN }}
```

This will trigger the generation of markdown documentation for every shell script in your repository containing the directive line described above (`#github-action genshdoc`).
The documentation is extracted from every script with the help of [vargiuscuola/shdoc](https://github.com/vargiuscuola/shdoc) and is stored in `REFERENCE-<script name>.md`.
An index file is also created in `REFERENCE.md`.

**Be careful!** Any `REFERENCE.md` file and `REFERENCE-<script name>.md` will be owerritten.
