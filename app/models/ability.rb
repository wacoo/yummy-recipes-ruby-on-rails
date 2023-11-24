class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # Guest user (not logged in)

    can :manage, :all if user.role == 'admin'

    can :manage, [Recipe, Food] do |resource|
      resource.user == user
    end

    can :manage, RecipeFood do |recipe_food|
      recipe_food.recipe.user == user
    end


end
