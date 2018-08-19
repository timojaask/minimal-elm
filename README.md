# minimal-elm
Bare minimum Elm project with Webpack

This is an example of an Elm project that can be published to [Netlify.com](https://www.netlify.com).

## Publishing on Netlify

1. Login to your [Netlify.com](https://www.netlify.com) account.
2. On choose "New site from Git"
3. Choose your repo provider (e.g. "Github")
4. Choose your repo (e.g. "timojaask/minimal-elm")
5. Set build command: `yarn build`
6. Set publish directory: `dist`
7. Choose "Deploy site"

## Creating this project from scratch

1. Create and clone a git repository
2. `cd` into the project directory
3. Run:

```
yarn init -y

yarn add webpack webpack-cli file-loader elm-webpack-loader --dev

elm-package install elm-lang/html
```

4. Add some required files:

`.gitignore`

```
node_modules
dist
.DS_Store
elm-stuff
```

`webpack.config.js`
```
var path = require('path');

module.exports = {
  entry: {
    app: [
      './src/index.js'
    ]
  },

  output: {
    path: path.resolve(__dirname + '/dist'),
    filename: '[name].js',
  },

  module: {
    rules: [
      {
        test: /\.html$/,
        exclude: /node_modules/,
        loader: 'file-loader?name=[name].[ext]',
      },
      {
        test: /\.elm$/,
        exclude: [/elm-stuff/, /node_modules/],
        loader: 'elm-webpack-loader?verbose=true&warn=true',
      },
    ],

    noParse: /\.elm$/,
  },

  devServer: {
    inline: true,
    stats: { colors: true },
  },
};
```

`src/index.html`

```
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8" />
  <title>Page title</title>
</head>
<body>
  <div id="main"></div>
  <script src="app.js"></script>
</body>
</html>
```

`src/index.js`

```
'use strict';

// Require index.html so it gets copied to dist
require('./index.html');

var Elm = require('./Main.elm');
var mountNode = document.getElementById('main');
var app = Elm.Main.embed(mountNode);
```

`src/Main.elm`

```
module Main exposing (..)
import Html exposing (Html, text, div)

type alias Model = {}

init : ( Model, Cmd Msg )
init = ( {}, Cmd.none )

type Msg = NoOp

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model = ( model, Cmd.none )

view : Model -> Html Msg
view model = div [] [ text "Hello, World!" ]

main : Program Never Model Msg
main =
  Html.program
    { view = view
    , init = init
    , update = update
    , subscriptions = always Sub.none
    }
```

5. Edit some necessary configs:

- In `elm-package.json` set `source-directories` to `"src"`:
```
"source-directories": [
  "src"
],
```

- In `package.json` remove `"main": "index.js",` line, and add scripts:
```
  "scripts": {
    "build": "webpack"
  },
```

6. Build using `yarn build`
