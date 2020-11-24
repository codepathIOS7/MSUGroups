Original App Design Project - README Template
===

# MSU Groups

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
This app will allow MSU students to create accounts and enter in the classes they're currently in to help them find groups of people in the same classes. Once they've entered in their classes, we have a directory of students for each class with the student's socials they consent to sharing (snapchat username, instagram profile, linkedin page, etc.) It could also help people find student groupchats for courses. Our hope is that this helps people feel more connected to others in their courses while we're all still virtual. We could either have users manually enter their course information, or if there was a way to gain access to course information through MSU we could use that as well.

### App Evaluation
- **Category:** Social
- **Mobile:** Mobile is essential because it allows students to instantly message each other.
- **Story:** With the ongoing pandemic, several students are having trouble meeting new people and finding people in their classes to study with. We recognized this problem, and this app could be a potential solution. 
- **Market:** This app can be useful to anyone that is a student at MSU. Students can find other students that are in the same classes as them and connect with them.
- **Habit:** Students can ask other students questions if they have any questions about the class throughout the day. They would also go on the app throughout the day when they receive notifications. Students will frequently be on this app when there is a big assignment or exam coming up.
- **Scope:** This is app narrowly focused. Users just  simply message each other. They can also view other user's socials.

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* Users can create/edit an account and login and logout of app 
* Users can add their socials to their accounts
* Users can add their classes to their accounts
* Students can view other students' socials based on classes they're in

**Optional Nice-to-have Stories**

* Users can be put into groups with other students based on their classes and message all the students

### 2. Screen Archetypes

* Login Screen
   * User can login
* Registration Screen
   * User can create a new account
* Courses Screen
    * User can navigate and find classes to get more information
* Class Screen
    * Shows class information including students and their respective socials
* Chat Screen
    * Has the chat history for the class
* Profile Screen
    * User can view profile
* Profile Edit Screen
    * User can make adjustments to profile



### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Classes
* Profile
* Chat

**Flow Navigation** (Screen to Screen)

* Login Screen
   * Profile Screen
   * Registration Screen
* Registration Screen
   * Profile Screen
   * Login Screen
* Class Screen
   * Chat Screen
   * Courses Screen
* Chat Screen
   * Class Screen
* Profile Screen
    * Profile Edit Screen
* Profile Edit Screen
    * Profile Screen
* Courses Screen
    * Class Screen


## Wireframes

<img src="https://i.imgur.com/bfB37w7.jpg" width=600>

## Schema 

### Models


Model: User
| Property | Type | Description |
| -------- | -------- | -------- |
| objectId     | String     | unique id for user     |
| userName | String | user's unique username |
| firstName     | String     | user's first name    |
| lastName     | String     | user's last name    |
| password | String | user's password |
| classes | Class [] | user's current classes |
| socials | Social [] | user's current socials |
| major | String | user's current major |
| profilePicture | File | user's profile picture |
| year | Number | user's current year |


Model: Class

| Property | Type    | Description|
| -------- | -------- | -------- |
| objectId     | String     | unique id for course     |
| students     | User []     | students in the course     |
| professor     | String     | proffesors for the class     |
| department     | String     | department code (CSE)     |
| courseNum | Number | course number |
| section | Number | section of this course |
| chat | Post [] | chats that come from this course |



Model: Social

| Property | Type     | Description |
| -------- | -------- | --------    |
|objectId     | String     | unique id for user    |
|socialType     | String     | type of social media account  |
|logo     | Image     | image for social  |
|user     | pointer to User      | user that owns that social |
|username | String | username of User |
| link | String | link that directs you to that page |



Model: Post

| Property | Type     | Description |
| -------- | -------- | --------    |
| objectId     | String     | unique id for user    |
| author   | Pointer to User    | author of this post    |
| image    | File     |  image that the user posts |
| caption    | String      | caption by author |
| numLikes | Number | the number of likes this chat has gotten |
| createdAt | DateTime | when the post was created |




### Networking

* Registration Screen
    * (Create/POST) Creating User profile
* Class Screen
    * (Read/GET) Fetches Classes' students list
    * (Read/GET) Fetches User's socials list
* Chat Screen
    * (Create/ POST) Sending a new post
    * (Delete/DELETE) Remove posts
    * (Update/PUT) like a post
    * (Read/GET) Fetches classes' posts
* Profile Screen
    * (Read/GET) Fetches User
    * (Read/GET) Fetches User's socials list
    * (Read/GET) Fetches User's class list
* Profile Edit Screen
    * (Update/PUT) User can update socials
    * (Update/PUT) Users can update the classes that they are in
    * (Update/PUT) Users can update the major
    * (Update/PUT) Users can update profile image
    * (Update/PUT) Users can update year
* Courses Screen
    * (Read/GET) Fetches users Class list
