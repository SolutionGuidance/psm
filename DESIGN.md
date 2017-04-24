# DESIGN.md


## User types

The PSM has four types of users, each with their own permission level:

1. __Service agent__
    
    Service agents should be able to create, view, and edit enrollments
    for their provider clients.

    - Can view: provider dashboard, enrollments, profile
    - Can create an enrollment
    - Can edit draft enrollments
    - Can view submitted enrollments
    
2. __Service admin__
    
    This user type can edit and view enrollments just as a service agent
    can, but it can also edit provider types and the screening schedule.
    This user type is most likely appropriate for someone working on the
    state side of the app.
    
    - Can view: provider dashboard and enrollments
    
    - Functions:
        - View and edit provider types
        - Edit screening schedule
        - Add and edit help topics
        - Add and edit agreements/addendums
        - View, create, edit, and delete other service agents

3. __System admin__
    
    This user type is purely for managing users, which none of the other
    user types can do.
    
    - Can only view "user account" screen
    - Functions
        - Create, edit, and delete users
        - Edit the abilities of user roles, but doesn't seem to be able
          to create new roles

4. __Providers__
    
    The user type with the lowest level of permissions, a provider
    should only be able to create, view, and edit their own enrollments.

    - View own enrollments
    - Create and edit enrollments
 