package gov.medicaid.entities;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "banner_texts")
public class BannerText {
    @Id
    @Column(name = "servlet_path")
    private String servletPath;

    @Column(
        name = "page_text",
        nullable = false
    )
    private String pageText;

    public String getServletPath() {
        return servletPath;
    }

    public void setServletPath(String servletPath) {
        this.servletPath = servletPath;
    }

    public String getPageText() {
        return pageText;
    }

    public void setPageText(String pageText) {
        this.pageText = pageText;
    }
}
