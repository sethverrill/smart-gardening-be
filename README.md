# Smart Gardening

## Description
Smart Gardening is an application that allows the user to determine which plants will thrive in their gardens by leveraging the power of OpenAI and Google Cloud API. By entering your location and plant needs, the app provides a tailored suggestions for a sucessful garden.  The app includes features such as:
- A homepage where the user can input their information.
- A detailed view of plants that would thrive.
- The ability to save those plants to your garden.
- The ability to navigate to your garden and see your plants.


## Installation Steps
1. Clone the Repository: [Smart Gardening](https://github.com/sethverrill/smart-gardening-be).
2. Install Dependencies:
```bundle install```
3. Set up the database: 
```rails db:create```
```rails db:migrate```
```rails db:seed```
4. Start Your rails server: 
```rails server```

## Routes
### Gardens Routes

GET /api/v1/gardens
- Lists all gardens.

GET /api/v1/gardens/:id
- Displays a specific garden by its ID.

POST /api/v1/gardens
- Creates a new garden.

PATCH /api/v1/gardens/:id
- Updates an existing garden by its ID.

### Plant Routes

GET /api/v1/gardens/:garden_id/plants
- Lists all plants in a specific garden.

PATCH /api/v1/gardens/:garden_id/plants
- Updates a plant in a specific garden.

DELETE /api/v1/gardens/:garden_id/plants/:plant_id
- Deletes a plant from a specific garden.

### Recommendation Routes
GET /api/v1/recommendation
- Provides recommendations.


## Links
- **Deployed Application**: [Smart Gardening Live Site](https://smart-gardening-fe.vercel.app/)
- **GitHub Back End Repository**: [Smart Gardening Back End Repository](https://github.com/sethverrill/smart-gardening-be)
- **GitHub Front End Repository**: [Smart Gardening Front End Repository](https://github.com/wally-yawn/smart_gardening_fe)
- **GitHub Project Board**: [Project Board](https://github.com/users/sethverrill/projects/5)

## Architecture
![App Architecture Diagram](./architecture.png)

## Team Members
#### Wally Wallace
- [LinkedIn Profile](https://www.linkedin.com/in/wally--wallace)
- [GitHub Profile](https://github.com/wally-yawn)

#### Seth Verrill
- [LinkedIn Profile](https://www.linkedin.com/in/sethverrill)
- [GitHub Profile](https://github.com/sethverrill)

#### Devlin Lynch
- [LinkedIn Profile](https://www.linkedin.com/in/devlin-lynch)
- [GitHub Profile](https://github.com/devklynch)

#### Kaelin Salazar
- [LinkedIn Profile](https://www.linkedin.com/in/kaelin-salazar)
- [GitHub Profile](https://github.com/kaelinpsalazar)

#### Bryan Willett
- [LinkedIn Profile](https://www.linkedin.com/in/bryan--willett)
- [GitHub Profile](https://github.com/bwillett2003)
