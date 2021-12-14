class AccountPolicy < ApplicationPolicy
	attr_reader :user, :account

	def create?
		user.admin?
	end
end