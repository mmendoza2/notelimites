web: bundle exec rails server thin -p $PORT -e $RACK_ENV
web: bundle exec puma -t 5:5 -p ${PORT:-3000} -e ${RACK_ENV:-development}
