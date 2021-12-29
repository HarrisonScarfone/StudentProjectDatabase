require 'test_helper'

class ProjectTest < ActiveSupport::TestCase

  test '.save saves a project with valid parameters' do
    create(:project,
      title: 'Random Project',
      year: 2021,
      abstract: 'T' * 100,
      video_link: 'https://www.youtube.com/embed/a46Ako2Y970',
      department: 'electrical'
    )
  end

  test '.save does not save a project without a title' do
    exception = assert_raises ActiveRecord::RecordInvalid do
      create(:project,
      title: nil,
      year: 2021,
      abstract: 'T' * 100,
      video_link: 'https://www.youtube.com/embed/a46Ako2Y970',
      department: 'electrical'
      )
    end

    assert_equal 'Validation failed: Title can\'t be blank, Title must be at least 10 characters',
      exception.message
  end

  test '.save does not save a project with a title less than 10 characters.' do
    exception = assert_raises ActiveRecord::RecordInvalid do
      create(:project,
      title: 'Too Short',
      year: 2021,
      abstract: 'T' * 100,
      video_link: 'https://www.youtube.com/embed/a46Ako2Y970',
      department: 'electrical'
      )
    end

    assert_equal 'Validation failed: Title must be at least 10 characters',
      exception.message
  end

  test '.save does not save a project without an abstract' do
    exception = assert_raises ActiveRecord::RecordInvalid do
      create(:project,
      title: 'Random Project',
      year: 2021,
      abstract: nil,
      video_link: 'https://www.youtube.com/embed/a46Ako2Y970',
      department: 'electrical'
      )
    end

    assert_equal 'Validation failed: Abstract can\'t be blank, Abstract must be at least 100 characters',
      exception.message
  end

  test '.save does not save a project with an abstract less than 100 characters' do
    exception = assert_raises ActiveRecord::RecordInvalid do
      create(:project,
      title: 'Random Project',
      year: 2021,
      abstract: 'T' * 99,
      video_link: 'https://www.youtube.com/embed/a46Ako2Y970',
      department: 'electrical'
      )
    end

    assert_equal 'Validation failed: Abstract must be at least 100 characters', exception.message
  end

  test '.save does not save a project without a youtube video link' do
    exception = assert_raises ActiveRecord::RecordInvalid do
      create(:project,
      title: 'Random Project',
      year: 2021,
      abstract: 'T' * 101,
      video_link: nil,
      department: 'electrical'
      )
    end

    assert_equal 'Validation failed: Video link can\'t be blank, Video link is not a valid youtube video embed link',
      exception.message
  end

  test '.save does not save a project without a valid youtube video link' do
    [
      'invalid://www.youtube.com/embed/a46Ako2Y970',
      'https://invalid.youtube.com/embed/a46Ako2Y970',
      'https://www.invalid.com/embed/a46Ako2Y970',
      'https://www.youtube.invalid/embed/a46Ako2Y970',
      'https://www.youtube.com/invalid/a46Ako2Y970',
      'invalid'
    ].each do |video_link|
      exception = assert_raises ActiveRecord::RecordInvalid do
        create(:project,
        title: 'Random Project',
        year: 2021,
        abstract: 'T' * 101,
        video_link: video_link,
        department: 'electrical'
        )
      end

      assert_equal 'Validation failed: Video link is not a valid youtube video embed link', exception.message
    end
  end

  test '.save does not save a project without a department' do
    exception = assert_raises ActiveRecord::RecordInvalid do
      create(:project,
      title: 'Random Project',
      year: 2021,
      abstract: 'T' * 101,
      video_link: 'https://www.youtube.com/embed/a46Ako2Y970',
      department: nil
      )
    end

    assert_equal 'Validation failed: Department can\'t be blank', exception.message
  end

  test '.save does not save a project without a valid department' do
    fake_department = 'social science'

    exception = assert_raises ArgumentError do
      create(:project,
      title: 'Random Project',
      year: 2021,
      abstract: 'T' * 101,
      video_link: 'https://www.youtube.com/embed/a46Ako2Y970',
      department: fake_department
      )
    end

    assert_equal "\'#{fake_department}\' is not a valid department", exception.message
  end
end
