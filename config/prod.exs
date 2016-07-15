use Mix.Config

config  :takobot,
  api_key: System.get_env("TAKOBOT_SLACK_TOKEN"),
  gyazo_upload_url: "https://upload.gyazo.com/api/upload",
  gyazo_token: System.get_env("GYAZO_TOKEN"),
  gyazo_access_token: System.get_env("GYAZO_ACCESS_TOKEN"),
  zen_api_url: "https://api.github.com/zen",
  lgtm_url: "http://www.lgtm.in/g",
  cat_url: "http://thecatapi.com/api/images/get",
  cat_token: System.get_env("CAT_TOKEN"),
  dcm_key: System.get_env("DOCOMO_DIALOGUE_API_KEY"),
  excuse_url: "http://programmingexcuses.com/",

  ul_key: System.get_env("UL_API_KEY"),
  ul_decompose: "https://chatbot-api.userlocal.jp/api/decompose",
  ul_chat: "https://chatbot-api.userlocal.jp/api/chat",
  ul_name: "https://chatbot-api.userlocal.jp/api/name"

  scripts_dir: System.get_env("HOME") <> "/app/elixir/takobot/scripts_prod"
