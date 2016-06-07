mix ecto.create : permet de créer la bdd

mix phoenix.server : lance le serveur

iex -S mix phoenix.server : lance le serveur en mode console interactive.
Ne peut pas être lancée en même temps qu'un serveur
iex -S mix : iex avec code applicatif loadé

mix ecto.create
mix ecto.gen.migration create_user : rails g migration ;)
mix ecto.migrate

changeset(model, params \\ :empty) : \\ :empty est un paramètre par défaut
:empty : par defaut utile pour que le ecto changeset le rejette lors d'une soumission vide

mix phoenix.routes : rake routes
form_for helper expect the Phoenix.HTML.Form-Data interface (Ecto.Changeset implement it)

mix deps.get = bundle install

erpca = endpoint -> routes -> pipeline -> controller -> action

PLUG = init and call. init compile time, call runtime. Slow things in init
pass a connection structure Plug.Conn https://hexdocs.pm/plug/Plug.Conn.html





TODO:
- Regarder implem des plugs put_flash et redirect. Redirect doit être le plus simple
- Regarder implem des helper html
- Regarder HTML.Form-Data
- Test circular dependecy with import (auth module)
