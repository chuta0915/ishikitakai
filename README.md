## heroku

```
heroku create ishikitakai
heroku addons:add heroku-postgresql:dev
heroku addons:upgrade pgbackups:auto-week
heroku addons:add pgbackups:auto-week
heroku addons:add newrelic
heroku domains:add ishikitakai.com
heroku addons:add pusher:sandbox
heroku addons:add sendgrid:starter
heroku addons:add papertrail:choklad
```

# how to start

* ```cp .env.sample .env```
* modify .env
* ```foreman start -f Procfile.development```
