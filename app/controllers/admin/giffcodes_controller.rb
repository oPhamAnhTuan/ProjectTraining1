class Admin::GiffcodesController < Admin::ApplicationController
  before_action :load_all_giffcode, only: :index

  def index; end

  private

  def load_all_giffcode
    @giffcode = Giffcode.list_all?
  end
end
