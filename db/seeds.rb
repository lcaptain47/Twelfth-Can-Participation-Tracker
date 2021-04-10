# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

UserRole.create(name: 'Officer', can_create: true, can_delete: true, can_delete_users: false, can_promote_demote: false, can_claim_unclaim: true, can_approve_unapprove: true)
UserRole.create(name: 'President', can_create: true, can_delete: true, can_delete_users: true, can_promote_demote: true, can_claim_unclaim: true, can_approve_unapprove: true)
UserRole.create(name: 'User', can_create: false, can_delete: false, can_delete_users: false, can_promote_demote: false, can_claim_unclaim: false, can_approve_unapprove: false)
