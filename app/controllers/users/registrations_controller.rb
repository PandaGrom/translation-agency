module Users
  class RegistrationsController < Devise::RegistrationsController
    before_action :configure_sign_up_params, only: [:create]
    before_action :configure_account_update_params, only: [:update]

    # GET /resource/sign_up

    # POST /resource

    # GET /resource/edit
    # def edit
    #   super
    # end

    # PUT /resource
    # def update
    #   super
    # end

    # DELETE /resource
    # def destroy
    #   super
    # end

    # GET /resource/cancel
    # Forces the session data which is usually expired after sign
    # in to be expired now. This is useful if the user wants to
    # cancel oauth signing in/up in the middle of the process,
    # removing all OAuth session data.
    # def cancel
    #   super
    # end

    # protected

    # If you have extra params to permit, append them to the sanitizer.
    def configure_sign_up_params
      devise_parameter_sanitizer.permit(:sign_up, keys: %i[role name contacts])
    end

    # If you have extra params to permit, append them to the sanitizer.

    def configure_account_update_params
      update_categories_for_user(params['user']['email'], params['user']['category_ids'])
      devise_parameter_sanitizer.permit(:account_update, keys: %i[name email password contacts category_ids pricing])
    end

    def update_categories_for_user(email, category_ids)
      @user = User.find_by(email: email)

      set_new_categories(category_ids)

      @user.save!
    end

    def drop_old_categories
      Category.where(categorable_id: @user.id).destroy_all
    end

    def set_new_categories(category_ids)
      category_titles = Category.where(id: category_ids).map(&:title)

      drop_old_categories

      category_titles.each do |title|
        Category.create(title: title, categorable_id: @user.id, categorable_type: 'User')
      end
    end

    # The path used after sign up.
    # def after_sign_up_path_for(resource)
    #   super(resource)
    # end

    # The path used after sign up for inactive accounts.
    # def after_inactive_sign_up_path_for(resource)
    #   super(resource)
    # end
  end
end
