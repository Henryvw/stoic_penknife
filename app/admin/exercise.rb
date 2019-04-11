ActiveAdmin.register Exercise do
  permit_params :user, :admin

  index do
    selectable_column
    id_column
    column :global
    column :title
    column :general_description
    column :category
    column :user_id
    column :created_at
    actions
  end

  filter :global
  filter :title
  filter :category
  filter :user_id
  filter :created_at

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if resource.something?
  #   permitted
  # end
end
