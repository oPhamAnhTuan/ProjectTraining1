class Course::V1::CourseController < Grape::API
  # before {authenticate_request!}

  resource :course_detail do
    desc "Load detail of course"
    params do
      requires :id, type: Integer, desc: 'course id.'
    end
    get do
      course = Course.find_by(id: params[:id]).load_structure
      render_js course
    end
  end
end
