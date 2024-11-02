module Users
  class RegistrationsController < Devise::RegistrationsController
    protected
    # hashをもとにresourceの新しいインスタンスを作る
    def build_resource(hash = {})
      hash[:uid] = User.create_unique_string
      super
    end

    def update_resource(resource, params)
      return super if params["password"].present?
    　　　　# 現在のパスワードなしでアカウントの更新をする
      resource.update_without_password(params.except("current_password"))
    end
  end
end
