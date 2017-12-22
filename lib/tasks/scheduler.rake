desc "This task is called by the Heroku scheduler add-on"

task :prueba => :environment do
  UserMailer.ntl_diario.deliver
end



task :ntl_user => :environment do
  # gmail = Gmail.connect("manuel@notelimites.com", "MegM880723")
  User.where('email is not NULL').order(:sign_in_count => 'DESC').first(200).each do |user|
    UserMailer.ntl_user(user).deliver

  end
  # gmail.logout
end


task :post_location => :environment do

  if Rails.env.development?
    uri = URI.parse("https://api.localhost.com:3000/v101/locations")
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Post.new("/v101/locations/")
    request.set_form_data({"location[lat]" => "25", "location[lng]" => "-100", "auth_token" => "i2gShFXzWnLF2A7f8_aQ"})
    response = http.request(request)
    puts  response
  else
    uri = URI.parse("https://api.notelimites.com/v101/locations")
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Post.new("/v101/locations/")
    request.set_form_data({"location[lat]" => "25.6", "location[lng]" => "-100.3", "auth_token" => "i2gShFXzWnLF2A7f8_aQ"})
    response = http.request(request)
  end



end

#---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#Guarda todos los users de la pagina de notelimites hacia el localhost
task :user_ntl => :environment do
  conn = PG.connect(:dbname => 'ntlcom_dev', user: 'Meme', password: 'manumanu')
  apiuser = ActiveSupport::JSON.decode(open("https://api.notelimites.com/v101/users?auth_token=i2gShFXzWnLF2A7f8_aQ").read)
  i = 1
  apiuser['users'].each do |user|
    i = 1 + i
    puts user['userID']

      conn.prepare(user['userID'].to_s, 'INSERT INTO users (id, name, email, slug, uid, created_at) values ($1, $2, $3, $4, $5, $6)')
      conn.exec_prepared(user['userID'].to_s, [ user['userID'], user['name'], user['email'],user['slug'], user['userUID'], DateTime.now  ])
  end
  # Se cierra conexion con BD -->
  conn.close
  puts "sirvio coneccion"
end



#---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#Guarda todos las agencias de la pagina de notelimites hacia el localhost
task :agencia_ntl => :environment do
  conn = PG.connect(:dbname => 'ntlcom_dev', user: 'Meme', password: 'manumanu')
  apiagencia = ActiveSupport::JSON.decode(open("https://api.notelimites.com/v101/agencies?auth_token=i2gShFXzWnLF2A7f8_aQ").read)
  i = 1
  apiagencia.each do |agencia|
    i = 1 + i
    puts agencia['id']
    if Agencie.exists?(uid: agencia['uid'])
    else
      conn.prepare(agencia['id'].to_s, 'INSERT INTO agencies (id, name, uid, created_at) values ($1, $2, $3, $4)')
      conn.exec_prepared(agencia['id'].to_s, [ agencia['id'], agencia['name'], agencia['uid'], DateTime.now  ])
    end
  end
  # Se cierra conexion con BD -->
  conn.close
  puts "sirvio coneccion"
end

#---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#Guarda todas las locations donde existen events de ticketmaster
task :location_ntl => :environment do
  conn = PG.connect(:dbname => 'ntlcom_dev', user: 'Meme', password: 'manumanu')

  #request.env['CONTENT_TYPE'] = 'application/json'

  apilocation = ActiveSupport::JSON.decode(open("https://api.notelimites.com/v101/locations?auth_token=i2gShFXzWnLF2A7f8_aQ").read)
  i = 1
  apilocation.each do |location|
    i = 1 + i
    puts i
    conn.prepare(i.to_s, 'INSERT INTO locations (id, slug, name, lat, lng, supplier_id, created_at) values ($1, $2, $3, $4, $5, $6, $7)')
    conn.exec_prepared(i.to_s, [  i, location['slug'],  location['name'], location['lat'], location['lng'], location['supplier_id'], location['created_at']  ])
  end
  # Se cierra conexion con BD -->
  conn.close

  puts "sirvio coneccion"
end

#---------------------------------------------------------FACEBOOK------------------------------------------------------------------------------------------------------------------
# Metodo con la forma completa para guardar la información de los events por medio de FACEBOOK.
def agenciafb(agencia, x, conn)

  unless agencia.name.blank?

    fbevent = ActiveSupport::JSON.decode(open("https://graph.facebook.com/v2.5/#{agencia.uid}?fields=events{cover,name,category,place,description,id,end_time,start_time,ticket_uri,photos,picture,comments,attending_count},name,location,category,username&access_token=EAACmRfp4e4EBAInSt7z6i4Ije56RxsWqdApBggz0gV7pt7AjqDroL60dVRi79BJgZCNMoXnSInl4ZCCwXXo2G8CYgZBu6ZAnkdHY5lN1tF5jgk3pKHZAmDNKl4sK7R9RQhZAbC0WhiykBALTLvNA6nV6VG82NtG7EZD").read)
    puts "Facebook response api exitosa"
    unless fbevent['events'].nil?
      category_id =	fbevent['category']
      if category_id == 'Bar' or category_id == 'Food/Beverages' or category_id == 'Arts/Entertainment/Nightlife' or category_id == 'club' or category_id == 'Comedian' or category_id == 'Restaurant/Cafe'
        category_id =  '3'
      elsif category_id == 'Concert Venue'  or  category_id =='Actor/Director' or category_id =='Artist' or category_id =='Musician/Band' or category_id =='Album' or category_id =='Concert Tour' or category_id =='Radio Station' or category_id =='Record Label' or category_id == 'Public Figure'
        category_id =  '1'
      elsif category_id == 'Outdoor Gear/Sporting Goods' or category_id =='Cars' or category_id =='Vitamins/Minerals' or category_id =='Athlete' or category_id =='Coach' or category_id =='Sports Venue' or category_id == 'Sports Team' or category_id == 'Sports/Recreation/Activities'
        category_id =  '2'
      elsif category_id == 'Book Store' or category_id =='Food/Beverages' or category_id =='Movie Theatre' or category_id =='Restaurant / Café' or category_id =='School' or category_id =='Shopping / Retail' or category_id =='Spas/Beauty/Personal Care' or category_id =='Church' or category_id =='Health/Beauty' or category_id =='Baby Goods/Kids Goods' or category_id =='Clothing' or category_id =='Furniture' or category_id =='Games/Toys' or category_id =='Health/Beauty' or category_id =='Kitchen/Cooking' or category_id =='Pet Supplies' or category_id =='Movie' or category_id == 'Food/Grocery'
        category_id =  '4'
      elsif category_id == 'Musuem/Art Gallery' or category_id =='Book' or category_id =='Library'
        category_id =  '5'
      else
        category_id =  '6'
      end

      # Si location no existe: Update de agencias  en Categoria_ID.  Si categoría no existe: Se agrega UID y NOMBRE en CATEGORIA
      if fbevent['location'].nil?
        conn.prepare( agencia.id.to_s, "UPDATE agencies SET  category_id='#{category_id}', facebook_category='#{fbevent['category']}', slug='#{fbevent['name'].parameterize}', uid='#{fbevent['id']}', updated_at='#{DateTime.now}'  WHERE name='#{fbevent['username']}' OR  name='#{fbevent['id']}'")
        conn.exec_prepared( agencia.id.to_s )

        # Si location existe: Update de agencias en Categoría con CITY Si categoría no existe: Se agrega UID y Nombre en CATEGORIA
      else
        puts   fbevent['id']
        puts   category_id
        puts   fbevent['category']
        puts   fbevent['username']
        puts   fbevent['name']
        puts   fbevent['location']['city']
        conn.prepare( agencia.id.to_s, "UPDATE agencies SET category_id='#{category_id}', facebook_category='#{fbevent['category']}', slug='#{fbevent['name'].parameterize}' , city='#{fbevent['location']['city']}', uid='#{fbevent['id']}', updated_at='#{DateTime.now}'  WHERE name='#{fbevent['username']}' OR  name='#{fbevent['id']}'")
        conn.exec_prepared( agencia.id.to_s)
        puts "1"
      end

      # Si el event está vacio en la AGENCIA de FACEBOOK -->
      result = fbevent['events']['data']
      i = 1
      j = 20
      k = 35
      y = 230
      puts "2"
      # Si va seleccionando event por event -->
      result.each do |event|
        i = 1 + i
        j = 20 + j
        k = 35 + k
        y = 39 + k

        puts "3...................COVER"
        #  Si no existe la foto de COVER no avanza -->
        unless event['cover'].nil?
          puts "4...................PLACE"
          # Si no existe venue relacionado no avanza -->
          unless event['place'].nil?
            puts "5...................PLACE ID"
            # Si no existe  venue relacionado no avanza -->
            unless event['place']['id'].nil?
               puts "6...................NAME"
               unless event['name'].nil?
                  # Si el event ya existe se hace Update de events: ATTENDING_COUNT, NOMBRE DE AGENCIA, AGENCIA_ID, CATEGORIA -->
                  if Event.exists?(uid: event['id'])
                    puts "7...................END TIME"
                    if  event['end_time'].nil?
                      conn.prepare( agencia.id.to_s + y.to_s, "UPDATE events SET official_url='https://www.facebook.com/events/#{event['id']}', agencie_id='#{event['id']}', supplier_id=2, category_id='#{category_id}', attending_count=#{event['attending_count']}, start_date='#{event['start_time'].in_time_zone("UTC" )}', end_date='#{( event['start_time'].to_date + 4.hours).to_date}', updated_at='#{DateTime.now}', image='#{event['cover']['source']}' WHERE uid='#{event['id'].parameterize}'")
                      conn.exec_prepared( agencia.id.to_s + y.to_s )
                    else
                      conn.prepare( agencia.id.to_s + y.to_s, "UPDATE events SET official_url='https://www.facebook.com/events/#{event['id']}', agencie_id='#{event['id']}', supplier_id=2, category_id='#{category_id}', attending_count=#{event['attending_count']}, start_date='#{event['start_time'].in_time_zone("UTC" )}', end_date='#{event['end_time']}', updated_at='#{DateTime.now}', image='#{event['cover']['source']}' WHERE uid='#{event['id'].parameterize}'")
                      conn.exec_prepared( agencia.id.to_s + y.to_s )
                    end
                    puts "8...................VENUE JSON............"
                    # JSON para  venue del event
                    fbplace = ActiveSupport::JSON.decode(open("https://graph.facebook.com/v2.5/#{event['place']['id']}?&fields=cover,checkins,name,location,likes,category_list,picture.width(600)&access_token=EAACmRfp4e4EBAInSt7z6i4Ije56RxsWqdApBggz0gV7pt7AjqDroL60dVRi79BJgZCNMoXnSInl4ZCCwXXo2G8CYgZBu6ZAnkdHY5lN1tF5jgk3pKHZAmDNKl4sK7R9RQhZAbC0WhiykBALTLvNA6nV6VG82NtG7EZD").read)
                    puts "Facebook venue response api exitosa"
                    puts "9...................VENUE ID"
                    # Si el venue ya existe: Se actualiza la información del place apenas que este exista
                    unless fbplace['id'].nil?
                      if Venue.exists?(uid: fbplace['id'])
                        puts "9...................LOCATION"
                        unless fbplace['location'].nil?
                          puts "9...................STREET"
                          unless fbplace['location']['street'].nil?
                            conn.prepare(agencia.id.to_s + k.to_s, "UPDATE venues SET place='#{ fbplace['location']['street'].tr("'", "") }', updated_at='#{DateTime.now}', image='#{fbplace['picture']['data']['url']}' WHERE uid='#{fbplace['id']}'")
                            conn.exec_prepared( agencia.id.to_s + k.to_s)
                          end
                        end
                        # Si el venue no existe: Se Crea apenas que contenga location
                      else
                        puts "10...................LATITUD"
                        unless fbplace['location']['latitude'].nil?
                          conn.prepare(fbplace['id']+j.to_s, 'INSERT INTO venues (uid, name, lat, lng, image, city, slug, created_at) values ($1, $2, $3, $4, $5, $6, $7, $8)')
                          conn.exec_prepared(fbplace['id']+j.to_s, [ fbplace['id'], fbplace['name'],fbplace['location']['latitude'],fbplace['location']['longitude'],fbplace['picture']['data']['url'], fbplace['location']['city'], fbplace['name'].parameterize, DateTime.now ])
                        end
                      end
                    end

                    # Si el event no existe:
                  else
                    # JSON para  venue del event
                    puts "11...................VENEU ID"
                    puts event['place']['id']
                    fbplace = ActiveSupport::JSON.decode(open("https://graph.facebook.com/v2.5/#{event['place']['id']}?&fields=cover,checkins,name,location,likes,category_list,picture.width(600)&access_token=EAACmRfp4e4EBAInSt7z6i4Ije56RxsWqdApBggz0gV7pt7AjqDroL60dVRi79BJgZCNMoXnSInl4ZCCwXXo2G8CYgZBu6ZAnkdHY5lN1tF5jgk3pKHZAmDNKl4sK7R9RQhZAbC0WhiykBALTLvNA6nV6VG82NtG7EZD").read)
                    puts "Facebook venue 2 response api exitosa"
                    #  Si el venue ya existe se checa si contiene: location -->
                    if Venue.exists?(uid: fbplace['id'])
                      puts "12...................LATITUD"
                      unless fbplace['location']['latitude'].nil?
                        puts " NUEVO event | VIEJO venue"
                        puts  event['name']
                        puts  event['description']
                        puts  event['id']
                        puts  event['start_time'].in_time_zone("UTC" )
                        puts  event['end_time']
                        puts  event['ticket_uri']
                        puts  event['place']['name']
                        puts  event['place']['id']
                        puts  event['attending_count']
                        puts  fbplace['id']
                        puts  fbplace['name']
                        puts  fbplace['location']['latitude']
                        puts  fbplace['picture']['data']['url']
                        puts  fbplace['location']['city']
                        puts  fbplace['location']['street']
                        puts  event['cover']['source']
                        #  Si contiene place, se acutaliza el place en venues  -->
                        unless fbplace['location']['street'].nil?
                          conn.prepare( event['id']+i.to_s, "UPDATE venues SET place='#{ fbplace['location']['street'].tr("'", "") }', updated_at='#{DateTime.now}' WHERE uid='#{fbplace['id']}'")
                          conn.exec_prepared( event['id']+i.to_s )
                        end
                        #  Se crea el event y se sube toda la información. venue si existe -->
                        conn.prepare(event['id']+j.to_s, 'INSERT INTO events (uid, name,  description, image, slug, start_date, end_date, venue_id, attending_count, category_id, created_at, supplier_id, agencie_id, official_url) values ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14)')
                        conn.exec_prepared(event['id']+j.to_s, [ event['id'], event['name'],event['description'],event['cover']['source'], event['name'].parameterize, event['start_time'].in_time_zone("UTC" ), (event['start_time'].in_time_zone("UTC" ).to_date + 4.hours).to_date, event['place']['id'], event['attending_count'], category_id, DateTime.now, 2,  event['id'], 'https://www.facebook.com/events/' + event['id'] ])
                      end
                      #  Si el venue no existe: se checa si tiene location -->
                    else
                      unless fbplace['location']['latitude'].nil?
                        puts  "NUEVO event | NUEVO venue"
                        puts event['name']
                        puts event['description']
                        puts event['id']
                        puts event['start_time'].in_time_zone("UTC" )
                        puts event['end_time']
                        puts event['ticket_uri']
                        puts event['place']['name']
                        puts event['place']['id']
                        puts event['attending_count']
                        puts fbplace['id']
                        puts fbplace['name']
                        puts fbplace['location']['latitude']
                        puts fbplace['picture']['data']['url']
                        puts fbplace['location']['city']
                        puts fbplace['location']['street']
                        puts event['cover']['source']


                        # Se crea venue con toda su informacióm -->
                        conn.prepare(fbplace['id']+k.to_s, 'INSERT INTO venues (uid, name, lat, lng, image, city, slug, created_at) values ($1, $2, $3, $4, $5, $6, $7, $8)')
                        conn.exec_prepared(fbplace['id']+k.to_s, [ fbplace['id'], fbplace['name'],fbplace['location']['latitude'],fbplace['location']['longitude'],fbplace['picture']['data']['url'], fbplace['location']['city'], fbplace['name'].parameterize, DateTime.now ])
                        #  Se crea event con toda su información -->
                        conn.prepare(event['id']+j.to_s, 'INSERT INTO events (uid, name,  description, image, slug, start_date, end_date, venue_id, attending_count, category_id, created_at, supplier_id, agencie_id, official_url) values ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14)')
                        conn.exec_prepared(event['id']+j.to_s, [ event['id'], event['name'],event['description'],event['cover']['source'], event['name'].parameterize, event['start_time'].in_time_zone("UTC" ), (event['start_time'].in_time_zone("UTC" ).to_date + 4.hours).to_date, event['place']['id'], event['attending_count'], category_id, DateTime.now, 2,  event['id'], 'https://www.facebook.com/events/' + event['id']])
                      end
                    end
                  end
                end
            end
          end
        end
      end
    end
  end
end

task :agenciafb_job1 => :environment do
  puts "actualizando agencias"
  if Rails.env.development?
    conn = PG.connect(:dbname => 'ntlcom_dev', user: 'Meme', password: 'manumanu')
  else
    conn = PG::Connection.new(:dbname => 'd2ofv83e85lbei', :host => 'ec2-184-73-202-229.compute-1.amazonaws.com', :user => 'rhsgfvcgtnszuj', :password => 'NSf6PWeYgHDe2tTnOVHbGSBMUw', :port => '5432', :sslmode => 'disable')
  end
  x = 0
  Agencie.all.limit(150).offset(0).order(:id => :ASC).each  do |agencia|
    x = x + 1
    puts "Agencia # #{x} ------------ #{agencia.id}"
    puts agencia.name
    agenciafb(agencia, x, conn)
  end
  # Se cierra conexion con BD -->
  conn.close
  puts "sirvio conexion"
end

task :agenciafb_job2 => :environment do
  puts "actualizando agencias"
  if Rails.env.development?
    conn = PG.connect(:dbname => 'ntlcom_dev', user: 'Meme', password: 'manumanu')
  else
    conn = PG::Connection.new(:dbname => 'd2ofv83e85lbei', :host => 'ec2-184-73-202-229.compute-1.amazonaws.com', :user => 'rhsgfvcgtnszuj', :password => 'NSf6PWeYgHDe2tTnOVHbGSBMUw', :port => '5432', :sslmode => 'disable')
  end
  x = 0
  Agencie.all.limit(150).offset(150).order(:id => :ASC).each  do |agencia|
    x = x + 1
    puts "Agencia # #{x} ------------ #{agencia.id}"
    puts agencia.name
    agenciafb(agencia, x, conn)
  end
  # Se cierra conexion con BD -->
  conn.close
  puts "sirvio coneccion"
end

task :agenciafb_job3 => :environment do
  puts "actualizando agencias"
  if Rails.env.development?
    conn = PG.connect(:dbname => 'ntlcom_dev', user: 'Meme', password: 'manumanu')
  else
    conn = PG::Connection.new(:dbname => 'd2ofv83e85lbei', :host => 'ec2-184-73-202-229.compute-1.amazonaws.com', :user => 'rhsgfvcgtnszuj', :password => 'NSf6PWeYgHDe2tTnOVHbGSBMUw', :port => '5432', :sslmode => 'disable')
  end
  x = 0
  Agencie.all.limit(150).offset(300).order(:id => :ASC).each  do |agencia|
    x = x + 1
    puts "Agencia # #{x} ------------ #{agencia.id}"
    puts agencia.name
    agenciafb(agencia, x, conn)
  end
  # Se cierra conexion con BD -->
  conn.close
  puts "sirvio coneccion"
end

task :agenciafb_job4 => :environment do
  puts "actualizando agencias"
  if Rails.env.development?
    conn = PG.connect(:dbname => 'ntlcom_dev', user: 'Meme', password: 'manumanu')
  else
    conn = PG::Connection.new(:dbname => 'd2ofv83e85lbei', :host => 'ec2-184-73-202-229.compute-1.amazonaws.com', :user => 'rhsgfvcgtnszuj', :password => 'NSf6PWeYgHDe2tTnOVHbGSBMUw', :port => '5432', :sslmode => 'disable')
  end
  x = 0
  Agencie.all.limit(150).offset(450).order(:id => :ASC).each  do |agencia|
    x = x + 1
    puts "Agencia # #{x} ------------ #{agencia.id}"
    puts agencia.name
    agenciafb(agencia, x, conn)
  end
  # Se cierra conexion con BD -->
  conn.close
  puts "sirvio coneccion"
end

#---------------------------------------------------------AGENCIAS MUCHAS------------------------------------------------------------------------------------------------------------------
# Tarea para sacar todas las agencias que se puedan sobre las agencias que ya existen
task :agencias => :environment do
  puts "Agregando muchas agencias"
  if Rails.env.development?
    conn = PG.connect(:dbname => 'ntlcom_dev', user: 'Meme', password: 'manumanu')
  else
    conn = PG::Connection.new(:dbname => 'd2ofv83e85lbei', :host => 'ec2-184-73-202-229.compute-1.amazonaws.com', :user => 'rhsgfvcgtnszuj', :password => 'NSf6PWeYgHDe2tTnOVHbGSBMUw', :port => '5432', :sslmode => 'disable')
  end
  x = 0
  Agencie.all.order(:id => :ASC).each  do |agencia|
    x = x + 1
    puts "Agencia # #{x} ------------ #{agencia.id}"
    puts agencia.name

    result = ActiveSupport::JSON.decode(open("https://graph.facebook.com/v2.5/#{agencia.name}?fields=name,events{is_page_owned,owner{id,username,name,category}}&access_token=EAACmRfp4e4EBAInSt7z6i4Ije56RxsWqdApBggz0gV7pt7AjqDroL60dVRi79BJgZCNMoXnSInl4ZCCwXXo2G8CYgZBu6ZAnkdHY5lN1tF5jgk3pKHZAmDNKl4sK7R9RQhZAbC0WhiykBALTLvNA6nV6VG82NtG7EZD").read())
    puts "Facebook response api exitosa"
    unless result['events'].nil?
      resultdata = result['events']['data']
      puts "result data"

      resultdata.each do |resultevent1|
        puts "resultevent1"

        if resultevent1['is_page_owned'] == 'false'
          puts "false"

        else
          puts "true"
          resultevent = resultevent1['owner']
          puts "what"
          unless resultevent.nil?



            category_id =	resultevent['category']
            puts "category"

            if category_id == 'Bar' or category_id == 'Food/Beverages' or category_id == 'Arts/Entertainment/Nightlife' or category_id == 'club' or category_id == 'Comedian' or category_id == 'Restaurant/Cafe'
              category_id =  '3'
            elsif category_id == 'Concert Venue'  or  category_id =='Actor/Director' or category_id =='Artist' or category_id =='Musician/Band' or category_id =='Album' or category_id =='Concert Tour' or category_id =='Radio Station' or category_id =='Record Label' or category_id == 'Public Figure'
              category_id =  '1'
            elsif category_id == 'Outdoor Gear/Sporting Goods' or category_id =='Cars' or category_id =='Vitamins/Minerals' or category_id =='Athlete' or category_id =='Coach' or category_id =='Sports Venue' or category_id == 'Sports Team' or category_id == 'Sports/Recreation/Activities'
              category_id =  '2'
            elsif category_id == 'Book Store' or category_id =='Food/Beverages' or category_id =='Movie Theatre' or category_id =='Restaurant / Café' or category_id =='School' or category_id =='Shopping / Retail' or category_id =='Spas/Beauty/Personal Care' or category_id =='Church' or category_id =='Health/Beauty' or category_id =='Baby Goods/Kids Goods' or category_id =='Clothing' or category_id =='Furniture' or category_id =='Games/Toys' or category_id =='Health/Beauty' or category_id =='Kitchen/Cooking' or category_id =='Pet Supplies' or category_id =='Movie' or category_id == 'Food/Grocery'
              category_id =  '4'
            elsif category_id == 'Musuem/Art Gallery' or category_id =='Book' or category_id =='Library'
              category_id =  '5'
            else
              category_id =  '6'
            end


            if Agencie.exists?(uid: resultevent['id'])

            else
              puts "nuevo"
              conn.prepare(resultevent['id']+j.to_s, 'INSERT INTO agencies (uid, name, category_id, facebook_category, slug, created_at) values ($1, $2, $3, $4, $5, $6)')
              conn.exec_prepared(resultevent['id']+j.to_s, [ resultevent['id'], resultevent['name'],category_id,resultevent['category'], resultevent['name'].parameterize, DateTime.now])
            end

          end
        end
      end
    end
  end
  # Se cierra conexion con BD -->
  conn.close
  puts "sirvio conexion"
end

#---------------------------------------------------------TICKETMASTER------------------------------------------------------------------------------------------------------------------
# Metodo con la forma completa para guardar la información de los events por medio de TICKETMASTER.
task :agenciatm_job1 => :environment do
  puts "actualizando agencias"

  if Rails.env.development?
    conn = PG.connect(:dbname => 'ntlcom_dev', user: 'Meme', password: 'manumanu')
  else
    conn = PG::Connection.new(:dbname => 'd2ofv83e85lbei', :host => 'ec2-184-73-202-229.compute-1.amazonaws.com', :user => 'rhsgfvcgtnszuj', :password => 'NSf6PWeYgHDe2tTnOVHbGSBMUw', :port => '5432', :sslmode => 'disable')
  end
  puts "conexion exitosa"
  i = 1
  j = 20
  k = 30
  z = 40

  Location.all.each do |location|
    i = 1 + i
    j = 20 + j
    k = 20 + k
    z = 20 + z

    if location.supplier_id == "1"
      puts location.id
      puts location.lat
      puts location.lng

      if location.lat
        puts  "-1"
        tmevents = ActiveSupport::JSON.decode(open("https://app.ticketmaster.com/discovery/v2/events.json?&latlong=#{location.lat},#{location.lng}&radius=100&size=50&apikey=pr9PDRemGQfrxHY7y8w2VcWMSCgaZ3nA").read)
        puts location.lat
        puts location.lng
      else
        puts  "-2"
        loc = ActiveSupport::JSON.decode(open("https://maps.googleapis.com/maps/api/geocode/json?address=#{location.slug}&key=AIzaSyClq051yZOiR1YEiaIRTuoi0I0gZgEWZKE").read)
        puts  "-3"
        lat =	 loc['results'][0]['geometry']['location']['lat']
        lng =	 loc['results'][0]['geometry']['location']['lng']
        tmevents = ActiveSupport::JSON.decode(open("https://app.ticketmaster.com/discovery/v2/events.json?&latlong=#{lat},#{lng}&radius=100&size=50&apikey=pr9PDRemGQfrxHY7y8w2VcWMSCgaZ3nA").read)
        puts location.slug
      end
      puts  "400"
      unless tmevents['_embedded'].nil?
        puts  "500"
        unless tmevents['_embedded']['events'].nil?
          puts  "600"
          tmevents['_embedded']['events'].each do |event|
            puts  "100"
            unless event['_embedded'].nil?
              puts  "200"
              unless event['classifications'].nil?
                unless event['_embedded']['venues'][0]['name'].nil?
                  unless event['dates']['start']['dateTime'].nil?



                    category_id = event['classifications'][0]['segment']['name']
                    if category_id == 'Bar'
                      category_id =  '3'
                    elsif category_id == 'Music'
                      category_id =  '1'
                    elsif category_id == 'Sports'
                      category_id =  '2'
                    elsif category_id == 'Book Store'
                      category_id =  '4'
                    elsif category_id == 'Arts & Theatre'
                      category_id =  '5'
                    else
                      category_id =  '6'
                    end

                    puts location.id
                    puts location.name

                    if Event.exists?(uid: event['id'])
                      #  Se actualiza event con TM -->
                      puts  ".......................................1 Evento Existe"
                      puts  event['id']
                      puts  event['name']
                      puts  event['info']
                      puts  event['attractions']
                      puts  event['dates']['start']['dateTime']
                      puts  event['images'][0]['url']
                      conn.prepare( event['id']+i.to_s, "UPDATE events SET category_id='#{category_id}', tm='true', official_url='#{event['url']}', start_date='#{event['dates']['start']['dateTime']}', end_date='#{(event['dates']['start']['dateTime'].to_date + 4.hours).to_date}', updated_at='#{DateTime.now}', image='#{event['images'][0]['url']}'  WHERE uid='#{event['id']}'")
                      conn.exec_prepared( event['id']+i.to_s )
                      puts event['url']
                      puts ".......................................Actualiza event"
                      event['_embedded']['venues'][0]
                      event['_embedded']['venues'][0]['id']
                    else
                      unless event['dates']['start']['dateTime'].nil?
                        # Se crea event con toda su información con toda su informacióm -->
                        puts  ".......................................2 Evento no existe"
                        puts  event['id']
                        puts  event['name']
                        puts  event['info']
                        puts  event['attractions']
                        puts  event['dates']['start']['dateTime']
                        conn.prepare(event['id']+j.to_s, 'INSERT INTO events (uid, name,  description, image, slug, start_date, end_date, venue_id, category_id, tm, official_url, supplier_id, created_at) values ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13)')
                        conn.exec_prepared(event['id']+j.to_s, [ event['id'], event['name'],event['info'],event['images'][0]['url'], event['name'].parameterize, event['dates']['start']['dateTime'], (event['dates']['start']['dateTime'].to_date + 4.hours).to_date , event['_embedded']['venues'][0]['id'], category_id, "true", event['url'], "1", DateTime.now])
                        puts ".......................................Se crea event"
                      end
                    end
                    #  Si el venue ya existe se checa si contiene: location -->
                    if Venue.exists?(uid: event['_embedded']['venues'][0]['id'])
                      #  Se actualiza venue con TM -->
                      puts  ".......................................3 Venue Existe"
                      puts event['_embedded']['venues'][0]['city']['name']
                      puts event['_embedded']['venues'][0]['url']
                      puts event['_embedded']['venues'][0]['id']
                      conn.prepare( event['id']+k.to_s, "UPDATE venues SET supplier_id='1', tm='1', image = 'https://s3.amazonaws.com/imagenes.notelimites/venue.jpg', city = '#{event['_embedded']['venues'][0]['city']['name'].gsub(/'/,' ')}', official_url='#{event['_embedded']['venues'][0]['url']}', updated_at='#{DateTime.now}'  WHERE uid='#{event['_embedded']['venues'][0]['id']}'")
                      conn.exec_prepared( event['id']+k.to_s )
                      puts ".......................................Se actualizo venue"
                    else
                      # Se crea venue con toda su informacióm -->

                      puts  ".......................................4 Venue no existe"
                      puts	 event['_embedded']['venues'][0]['name']
                      puts	 event['_embedded']['venues'][0]['type']
                      puts   event['_embedded']['venues'][0]['id']
                      puts	 event['_embedded']['venues'][0]['url']
                      puts	 event['_embedded']['venues'][0]['city']['name']
                      puts	 event['_embedded']['venues'][0]['address']
                      puts	 event['_embedded']['venues'][0]['location']
                      puts   event['_embedded']['venues'][0]['location']['longitude']
                      puts   event['_embedded']['venues'][0]['location']['latitude']

                      conn.prepare(event['id']+z.to_s, 'INSERT INTO venues (uid, name, lat, lng, city, slug, official_url, tm, image, supplier_id, created_at) values ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11)')
                      conn.exec_prepared(event['id']+z.to_s, [ event['_embedded']['venues'][0]['id'], event['_embedded']['venues'][0]['name'],event['_embedded']['venues'][0]['location']['latitude'],event['_embedded']['venues'][0]['location']['longitude'], event['_embedded']['venues'][0]['city']['name'], event['_embedded']['venues'][0]['name'].parameterize, event['_embedded']['venues'][0]['url'], 1, "https://s3.amazonaws.com/imagenes.notelimites/venue.jpg", "1", DateTime.now])
                      puts ".......................................Se crea venue"

                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
# Se cierra conexion con BD -->
  conn.close
  puts "Se cerro conexion"
end
#---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#Borrar events de días anteriores y relaciones pasadas
task :borrar_eventos_pasados => :environment do
  if Rails.env.development?
    conn = PG.connect(:dbname => 'ntlcom_dev', user: 'Meme', password: 'manumanu')
  else
    conn = PG::Connection.new(:dbname => 'd2ofv83e85lbei', :host => 'ec2-184-73-202-229.compute-1.amazonaws.com', :user => 'rhsgfvcgtnszuj', :password => 'NSf6PWeYgHDe2tTnOVHbGSBMUw', :port => '5432', :sslmode => 'disable')
  end

  i = 1
  j = 200
  k = 30
  z = 40

  puts "Numero total de events"
  puts Event.count

  events_pasados = Event.all.where('start_date < ?' , DateTime.now - 365.day )
  events_pasados.each do |event|
    puts event.start_date
    conn.prepare( event.id.to_s, "DELETE FROM events WHERE UID = '#{event.uid}' ")
    conn.exec_prepared( event.id.to_s )
  end

      puts "Numero total de events actualizado"
  puts Event.count
  conn.close
  puts "Se cerro conexion"
end

#---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#Borrar Agencias Duplicadas y con uid empty
task :borrar_agencias_duplicadas => :environment do
  if Rails.env.development?
    conn = PG.connect(:dbname => 'ntlcom_dev', user: 'Meme', password: 'manumanu')
  else
    conn = PG::Connection.new(:dbname => 'd2ofv83e85lbei', :host => 'ec2-184-73-202-229.compute-1.amazonaws.com', :user => 'rhsgfvcgtnszuj', :password => 'NSf6PWeYgHDe2tTnOVHbGSBMUw', :port => '5432', :sslmode => 'disable')
  end
  i = 1
  j = 200
  k = 30
  z = 40
  puts "Numero total de agencias"
  puts Agencie.count
  puts "Se borran agencias duplicadas y con UID empty"
  conn.prepare( "UNO", "DELETE FROM AGENCIES WHERE exists (select 1
                                                                      from agencies t2
                                                                            where t2.name = agencies.name and
                                                                            t2.ctid > agencies.ctid
                                                                     )
                  ")
  conn.exec_prepared( "UNO" )
  conn.prepare( "DOS", "DELETE FROM AGENCIES WHERE UID IS NULL  ")
  conn.exec_prepared( "DOS")
  puts "Numero total de agencies actualizado"
  puts Agencie.count
  conn.close
  puts "Se cerro conexion"
end

#---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#Borrar Locations Duplicadas y con name
task :borrar_locations_duplicadas => :environment do
  if Rails.env.development?
    conn = PG.connect(:dbname => 'ntlcom_dev', user: 'Meme', password: 'manumanu')
  else
    conn = PG::Connection.new(:dbname => 'd2ofv83e85lbei', :host => 'ec2-184-73-202-229.compute-1.amazonaws.com', :user => 'rhsgfvcgtnszuj', :password => 'NSf6PWeYgHDe2tTnOVHbGSBMUw', :port => '5432', :sslmode => 'disable')
  end
  i = 1
  j = 200
  k = 30
  z = 40
  puts "Numero total de locations"
  puts Location.count
  puts "Se borran agencias duplicadas y con UID empty"
  conn.prepare( "UNO", "DELETE FROM LOCATIONS WHERE exists (select 1
                                                                      from locations t2
                                                                            where t2.name = locations.name and
                                                                            t2.ctid > locations.ctid
                                                                     )
                  ")
  conn.exec_prepared( "UNO" )
  conn.prepare( "DOS", "DELETE FROM LOCATIONS WHERE NAME IS NULL  ")
  conn.exec_prepared( "DOS")
  puts "Numero total de locations actualizado"
  puts Location.count
  conn.close
  puts "Se cerro conexion"
end


#---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#Borrar Locations Duplicadas y con name
task :locations_con_eventos => :environment do
  if Rails.env.development?
    conn = PG.connect(:dbname => 'ntlcom_dev', user: 'Meme', password: 'manumanu')
  else
    conn = PG::Connection.new(:dbname => 'd2ofv83e85lbei', :host => 'ec2-184-73-202-229.compute-1.amazonaws.com', :user => 'rhsgfvcgtnszuj', :password => 'NSf6PWeYgHDe2tTnOVHbGSBMUw', :port => '5432', :sslmode => 'disable')
  end
  i = 1
  j = 200
  k = 30
  z = 40
  puts "Numero total de locations"

  puts Location.where(:tm => 1).count

  puts "Se actualizan locations sin eventos"
  puts "......................"
  Location.all.each do |x|
        latdown = x.lat.to_f - 0.2
        latup = x.lat.to_f + 0.2
        lngdown = x.lng.to_f + 0.2
        lngup = x.lng.to_f - 0.2
        events=  Event.joins(:venue).where(:venues => {:lat => [(latdown..latup)] } ).where(:venues => {:lng => [(lngdown..lngup)] } ).where('start_date > ?' , DateTime.now ).order(:start_date => 'ASC')
        if events.blank?
              puts x.id
              conn.prepare( x.id.to_s, "UPDATE LOCATIONS SET tm= false, supplier_id = 0 where  id = #{x.id}   ")
              conn.exec_prepared( x.id.to_s )
        else
              puts x.id
              conn.prepare( x.id.to_s, "UPDATE LOCATIONS SET tm= true where  id = #{x.id}   ")
              conn.exec_prepared( x.id.to_s )
        end
  end
  puts "......................"
  puts "Numero total de locations actualizado"
  puts Location.where(:tm => 1).count
  conn.close
  puts "Se cerro conexion"
end
