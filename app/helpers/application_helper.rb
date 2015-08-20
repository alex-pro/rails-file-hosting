module ApplicationHelper
  def check_render_file(i)
    if i.image?
      link_to i.file.url, id: "gallery" do
        image_tag i.file.url, alt: "#{i.name}"
      end
    elsif i.audio?
      link_to i.file.url, class: "mfp-iframe", id: "gallery" do
        image_tag "audio.png", alt: "#{i.name}"
      end
    elsif i.video?
      link_to i.file.url, class: "mfp-iframe", id: "gallery" do
        image_tag "video.png", alt: "#{i.name}"
      end
    else
      link_to "", id: "gallery" do
        image_tag "doc.png", alt: "#{i.name}"
      end
    end
  end
end
