import Dao.CourseEntity;
import org.hibernate.HibernateException;
import org.hibernate.Metamodel;
import org.hibernate.query.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

import javax.persistence.metamodel.EntityType;

import java.util.List;
import java.util.Map;

public class Main {


    public static void main(final String[] args) throws Exception {
        Configuration configuration= new Configuration().configure();

        SessionFactory sessionFactory=configuration.buildSessionFactory();

        Session session=sessionFactory.openSession();
        try {
            System.out.println("querying all the managed entities...");

//            final Metamodel metamodel = session.getSessionFactory().getMetamodel();
//            for (EntityType<?> entityType : metamodel.getEntities()) {
//                final String entityName = entityType.getName();

            Query query = session.createQuery("from CourseEntity ");
            List<CourseEntity> courses=query.list();
                System.out.println("executing: " + query.getQueryString());
                for (CourseEntity course : courses) {
                    System.out.println("  " + course.getCouId());
                }

        } finally {
            session.close();
            sessionFactory.close();
        }

    }
}