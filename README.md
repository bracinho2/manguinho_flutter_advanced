# manguinho_flutter_advanced

A new Flutter project.

## GIT

Algumas anotações do GIT para nosso Projeto

- Comandos GIT nativos;

```bash
git init
git add .
git commit -m "Initial Setup"
git push origin main
```

- Edição da configuração global;

```bash
git config --edit --global
```

- Alterações realizadas;

```git
[user]
	email = bracinho2@hotmail.com
	name = Alexandre | BrAcInhO
[init]
	defaultBranch = main
[core]
	editor = code --wait
[alias]
	s = !git status -s
	c = !git add . && git commit -m
	amend = !git add . && git commit --amend --no-edit
	l = !git log --pretty=format:'%C(blue)%h%C(red)%d %C(white)%s %C(cyan)[%cn] %C(green)%cr'
```

## Editor Config
EditorConfig is awesome: https://EditorConfig.org

## Double Tests
- Mock: precupaçao com input;
- stube: preocupação com o output;
- spy: preocupação com input e output;

## TDD

"SUT";

Red
Green
Refactor

## Concepts
KIS
DRY
YAGNI principle ("You Aren't Gonna Need It")

# Dart Modifiers
