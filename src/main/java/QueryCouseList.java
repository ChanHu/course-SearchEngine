package servlet;

import Dao.CourseEntity;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;
import org.hibernate.query.Query;

import java.util.List;

public class QueryCouseList {
    public List<CourseEntity>  queryCourseList() throws Exception{

        Configuration configuration= new Configuration().configure();

        SessionFactory sessionFactory=configuration.buildSessionFactory();

        Session session=sessionFactory.openSession();

        List<CourseEntity> courses =null;
        try {
            System.out.println("querying all the Course entities...");

            Query query = session.createQuery("from CourseEntity ");
            courses=query.list();
            System.out.println("executing: " + query.getQueryString());
            for (CourseEntity course : courses) {
                System.out.println("  " + course.getCouId());
            }

        } finally {
            session.close();
            sessionFactory.close();
        }
        return  courses;
    }


}
