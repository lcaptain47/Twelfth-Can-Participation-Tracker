class AddMorePermissionsToUserRoles < ActiveRecord::Migration[6.1]
  def change
    add_column :user_roles, :can_delete_users, :boolean
    add_column :user_roles, :can_promote_demote, :boolean
    add_column :user_roles, :can_claim_unclaim, :boolean
    add_column :user_roles, :can_approve_unapprove, :boolean
  end
end
