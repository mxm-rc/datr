class FriendPolicy < ApplicationPolicy
  def show?
    Accointance.exists?(follower: user, recipient: record) || Accointance.exists?(follower: record, recipient: user)
  end

end
