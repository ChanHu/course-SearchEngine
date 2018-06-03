import Dao.CourseEntity;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;
import org.hibernate.query.Query;
import java.util.List;

public class HibernateTest {


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