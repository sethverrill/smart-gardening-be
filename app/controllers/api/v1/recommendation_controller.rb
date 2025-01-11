class Api::V1::RecommendationController < ApplicationController

  def index
    #call the openai gateway method to actually get data using params

    stub_json = {
      data: [
        {
          id: 1,
          type: "plant",
          attributes: {
            name: 'strawberry',
            short_description: 'red',
            img_url: 'https://foodal.com/wp-content/uploads/2015/03/Make-Strawberry-Season-Last-All-Year.jpg'}
        },
        {
          id: 2,
          type: "plant",
          attributes: {
            name: 'basil',
            short_description: 'green',
            img_url: 'https://the-growers.com/wp-content/uploads/2019/04/Basil-Leaves-Closeup.jpg'}
        }
      ]
    }

    render json: RecommendationSerializer.format_recommendations(stub_json[:data]), status: 200
  end
  
end