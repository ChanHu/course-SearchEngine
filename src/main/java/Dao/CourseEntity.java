package Dao;

import javax.persistence.*;

@Entity
@Table(name = "course", schema = "course", catalog = "")
public class CourseEntity {
    private String couId;
    private String couName;
    private String couTeacher;
    private String couSchool;
    private Double couEval;
    private Integer couEvalAmount;
    private Integer couAttendAmount;
    private Byte couIsCountry;
    private Double couScore;

    @Id
    @Column(name = "CouId", nullable = false, length = 255)
    public String getCouId() {
        return couId;
    }

    public void setCouId(String couId) {
        this.couId = couId;
    }

    @Basic
    @Column(name = "CouName", nullable = false, length = 255)
    public String getCouName() {
        return couName;
    }

    public void setCouName(String couName) {
        this.couName = couName;
    }

    @Basic
    @Column(name = "CouTeacher", nullable = true, length = 255)
    public String getCouTeacher() {
        return couTeacher;
    }

    public void setCouTeacher(String couTeacher) {
        this.couTeacher = couTeacher;
    }

    @Basic
    @Column(name = "CouSchool", nullable = true, length = 255)
    public String getCouSchool() {
        return couSchool;
    }

    public void setCouSchool(String couSchool) {
        this.couSchool = couSchool;
    }

    @Basic
    @Column(name = "CouEval", nullable = true, precision = 3)
    public Double getCouEval() {
        return couEval;
    }

    public void setCouEval(Double couEval) {
        this.couEval = couEval;
    }

    @Basic
    @Column(name = "CouEvalAmount", nullable = true)
    public Integer getCouEvalAmount() {
        return couEvalAmount;
    }

    public void setCouEvalAmount(Integer couEvalAmount) {
        this.couEvalAmount = couEvalAmount;
    }

    @Basic
    @Column(name = "CouAttendAmount", nullable = true)
    public Integer getCouAttendAmount() {
        return couAttendAmount;
    }

    public void setCouAttendAmount(Integer couAttendAmount) {
        this.couAttendAmount = couAttendAmount;
    }

    @Basic
    @Column(name = "CouIsCountry", nullable = true)
    public Byte getCouIsCountry() {
        return couIsCountry;
    }

    public void setCouIsCountry(Byte couIsCountry) {
        this.couIsCountry = couIsCountry;
    }

    @Basic
    @Column(name = "CouScore", nullable = true, precision = 10)
    public Double getCouScore() {
        return couScore;
    }

    public void setCouScore(Double couScore) {
        this.couScore = couScore;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        CourseEntity that = (CourseEntity) o;

        if (couId != null ? !couId.equals(that.couId) : that.couId != null) return false;
        if (couName != null ? !couName.equals(that.couName) : that.couName != null) return false;
        if (couTeacher != null ? !couTeacher.equals(that.couTeacher) : that.couTeacher != null) return false;
        if (couSchool != null ? !couSchool.equals(that.couSchool) : that.couSchool != null) return false;
        if (couEval != null ? !couEval.equals(that.couEval) : that.couEval != null) return false;
        if (couEvalAmount != null ? !couEvalAmount.equals(that.couEvalAmount) : that.couEvalAmount != null)
            return false;
        if (couAttendAmount != null ? !couAttendAmount.equals(that.couAttendAmount) : that.couAttendAmount != null)
            return false;
        if (couIsCountry != null ? !couIsCountry.equals(that.couIsCountry) : that.couIsCountry != null) return false;
        if (couScore != null ? !couScore.equals(that.couScore) : that.couScore != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = couId != null ? couId.hashCode() : 0;
        result = 31 * result + (couName != null ? couName.hashCode() : 0);
        result = 31 * result + (couTeacher != null ? couTeacher.hashCode() : 0);
        result = 31 * result + (couSchool != null ? couSchool.hashCode() : 0);
        result = 31 * result + (couEval != null ? couEval.hashCode() : 0);
        result = 31 * result + (couEvalAmount != null ? couEvalAmount.hashCode() : 0);
        result = 31 * result + (couAttendAmount != null ? couAttendAmount.hashCode() : 0);
        result = 31 * result + (couIsCountry != null ? couIsCountry.hashCode() : 0);
        result = 31 * result + (couScore != null ? couScore.hashCode() : 0);
        return result;
    }
}
