# ishikitakai.com

Community management system.

## for rvm user

Check ruby version.

```
cat .rvmrc.sample
```

```
cp .rvmrc.sample .rvmrc
```

Customize .rvmrc for your environment.

```
vim .rvmrc
```

Trust .rvmrc

```
cd .. && cd -
```

```
====================================================================================
= NOTICE                                                                           =
====================================================================================
= RVM has encountered a new or modified .rvmrc file in the current directory       =
= This is a shell script and therefore may contain any shell commands.             =
=                                                                                  =
= Examine the contents of this file carefully to be sure the contents are          =
= safe before trusting it! ( Choose v[iew] below to view the contents )            =
====================================================================================
Do you wish to trust this .rvmrc file? (/{path_to_your_project_dir}/zoochat/.rvmrc)
y[es], n[o], v[iew], c[ancel]> 
```

Enter 'y'

## development

Customize .env for your environment.

```
cp .env.sample .env
vim .env
```

```
foreman start -f Procfile.development
```

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

### production

```
heroku addons:add ssl
```
