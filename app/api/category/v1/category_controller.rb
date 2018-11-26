class Category::V1::CategoryController < Grape::API

  resource :list_category do
    desc "Load all category on view"
    get do
      category = Category.category_select
      render_js category
    end
  end

  resource :category_course do
    desc "Load all category with course"
    get do
      category = []
      Category.all.each{|c| category.push c.load_structure}
      render_js category
    end
  end

  resource :course_in_category do
    desc "Load all course of category"
    params do
      requires :id, type: Integer, desc: 'Status id.'
    end
    get do
      course = Category.find_by(id: params[:id]).load_structure
      render_js course
    end
  end
end
