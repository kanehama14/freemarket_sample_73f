class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:facebook, :google_oauth2]

  validates :name, :first_name, :last_name, :first_name_kana, :last_name_kana, :birthday ,presence: true
  validates :first_name,:last_name,
            format: {
              with: /\A(?:\p{Hiragana}|\p{Katakana}|[ー－]|[一-龠々])+\z/,
              message: "は全角で入力して下さい"
            }
  validates :first_name_kana,:last_name_kana,
            format: {
              with: /\A[ぁ-んー－]+\z/,
              message: "は全角ひらがなのみで入力して下さい"
            }

  #validates :password, :password_confirmation,
  #          format: {
  #            with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i,
  #            message: "は英数字を1文字以上含む必要があります"
  #          }

  has_many :cards
  has_many :items
  has_one :address
  has_many :sns_credentials
  
  def self.from_omniauth(auth)
    sns = SnsCredential.where(provider: auth.provider, uid: auth.uid).first_or_create
    # sns認証したことがあればアソシエーションで取得
    # 無ければemailでユーザー検索して取得orビルド(保存はしない)
    user = sns.user || User.where(email: auth.info.email).first_or_initialize(
      name: auth.info.name,
      email: auth.info.email
    )
    # userが登録済みの場合はそのままログインの処理へ行くので、ここでsnsのuser_idを更新しておく
    if user.persisted?
      sns.user = user
      sns.save
    end
    # SNS認証したかどうかを判定するために、@snsという変数を新規登録画面に持っていくため
    { user: user, sns: sns }
  end

end
