# Sudoku

Programme interactif non graphique du jeu Sudoku

## Prérequis

- [Ruby](https://www.ruby-lang.org/fr/) >= 2.6.5

## Installation

```bash
git clone https://github.com/stunox/Sudoku.git
cd Sudoku
ruby sudoku.rb
```

## Utilisation

```bash
X Y N : Pour placer le chiffre N à la position X Y, puis taper entrée
R : Pour lire les règles
H : Pour afficher la valeur la plus utilisée dans la grille
Q : Pour quitter
```

## Règles

- Chaque ligne doit contenir tous les chiffres de 1 à n, n étant la taille de la grille
- Chaque colonne doit contenir tous les chiffres de 1 à n, n étant la taille de la grille
- Chaque sous-grille, appelé bloc, doit contenir tous les chiffres de 1 à n, n étant la taille de la grille
- ~~Il n'est pas possible d'effacer un chiffre déjà placé~~
- **_UPDATE_ : Il est désormais possible d'effacer un chiffre déjà placé en le remplaçant par un 0, hormis les chiffres initiaux**

## Auteur

- [**B. Nabil**](https://github.com/stunox)
