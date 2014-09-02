module ApplicationHelper
  include DMHelper

  def pri_display_selector
    @ret[:primary_id][:name]
  end

  def pri_id_selector
    @ret[:primary_id][:id]
  end

  def pri_display_helper
    @ret[:primary][pri_display_selector]
  end

  def pri_id_helper
    @ret[:primary][pri_id_selector]
  end

  def cur_display_selector
    @ret[:current_id][:name]
  end

  def cur_id_selector
    @ret[:current_id][:id]
  end

  def cur_display_helper
    @ret[:current][cur_display_selector]
  end

  def cur_id_helper
    @ret[:current][cur_id_selector]
  end
end
