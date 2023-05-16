# Reciplease

Reciplease suggests recipes based on the ingredients in your fridge, making cooking easy and convenient. 
No more wondering what to cook - find delicious recipes using the ingredients you you already have.

|Search|Result|Details|Favorites|
|--|--|--|--|
|<img src="/Resources/Demo-iPhone-14-Search-Ingredients.png" width="150">|<img src="/Resources/Demo-iPhone-14-Search-Result.png" width="150">|<img src="/Resources/Demo-iPhone-14-RecipeDetails.png" width="150">|<img src="/Resources/Demo-iPhone-14-FavoriteRecipes.png" width="150">|
|<img src="/Resources/Demo-iPhone-14-Search-Ingredients-Dark.png" width="150">|<img src="/Resources/Demo-iPhone-14-Search-Result-Dark.png" width="150">|<img src="/Resources/Demo-iPhone-14-RecipeDetails-Dark.png" width="150">|<img src="/Resources/Demo-iPhone-14-FavoriteRecipes-Dark.png" width="150">|

## Requirements

* iOS 16.0+

## Usage

1. List your fridge ingredients with an autocomplete search.
2. Find recipes based on your ingredients list.
3. Add the recipe(s) to your favorites list.
4. Find out how to cook a recipe by getting all the details.
5. Get back to your previous ingredient list and favorite recipes (persistent storage).

## Dependency

* This application requires the pod Alamofire 5.7+.
    * To install it, follow these instructions: [Alamofire on CocoaPods](https://cocoapods.org/pods/Alamofire)

* Edamam Recipe Search API and Food Database API ID/Keys are present, but may not be active forever.
    * You can create your own IDs/Keys for free here: [Edamam](https://www.edamam.com/)

## Features

* Search tab
    * Autocompletion for ingredient search.
    * Menu to clear or reload the ingredients list.
    * Possibility to remove one specific ingredient.
    * After "Search for Recipes", you can select a recipe to see details.
    * Possibility to add the recipe to your favorites by tapping the star on the top right corner of the screen.
    * Your fridge ingredients list is kept after you search for recipes (persistent storage).

* Favorites tab
    * Shows a list of your favorite recipes.
    * You can remove a recipe from your favorites by tapping on the star.
    * Your favorite recipes are stored on a persistent basis.

* Settings tab
    * You can find a description of the application through "About".
    * You can also change the appearance mode and keep it for the next opening of the app (persistant storage)

* Responsive Layout from the iPhone SE (3rd Generation) to the last version.
* Optimized API calls (URL cached response).
* Use of accessibilityLabel/accessibilityHint for UIKit elements not clearly identified by VoiceOver.

## Structure

* Clean Architecture + MVVM.
Inspired by [Oleh Kudinov's Medium article](https://tech.olx.com/clean-architecture-and-mvvm-on-ios-c9d167d9f5b3).

## Demo

<img src="/Resources/Demo-iPhone-14-Reciplease.gif" width="220">

## License

See [LICENSE](/LICENSE) for details
