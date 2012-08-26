## heroku

```
heroku create ishikitakai
heroku addons:add heroku-postgresql:dev
heroku addons:upgrade pgbackups:auto-week
heroku addons:add pgbackups:auto-week
heroku addons:add newrelic
heroku domains:add ishikitakai.com
```
