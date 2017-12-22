class SearchController < ApplicationController
 def index

       search =  params[:search]
       if location = Location.friendly.find_by(:name => params[:search])
          redirect_to location
       else
         @results =  Location.search(params[:search])
       end

 end

end
