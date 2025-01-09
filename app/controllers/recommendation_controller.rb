class API::V1:RecommendationController < ApplicationController

  def index
    #call the openai gateway method to actually get data
    require 'pry'; binding.pry
    stub_json = {
      data: {
        id: 1,
        attributes: {[
          name: 'strawberry',
          short_description: 'red'
          img_url: 'https://foodal.com/wp-content/uploads/2015/03/Make-Strawberry-Season-Last-All-Year.jpg',
          
          name: 'basil',
          short_description: 'spicy'
          img_url: 'https://joegardener.com/wp-content/uploads/2021/07/AMP_9588-708X466.jpg'
          ]
        }
      }
    }



  end
end