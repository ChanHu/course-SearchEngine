import Dao.CourseEntity;
import org.apache.lucene.analysis.Analyzer;
import org.apache.lucene.analysis.standard.StandardAnalyzer;
import org.apache.lucene.document.Document;
import org.apache.lucene.document.Field;
import org.apache.lucene.index.IndexWriter;
import org.apache.lucene.store.Directory;
import org.apache.lucene.store.FSDirectory;


import java.io.File;
import java.util.ArrayList;
import java.util.List;

public class CreatIndexWriter {
    public static void main( String[] args) throws Exception {
        List<CourseEntity> courses=new QueryCouseList().queryCourseList();
        List<Document> doclist=new ArrayList<Document>();
        Document document;
        for(CourseEntity course: courses){
            document=new Document();
            Field id = new Field("id",course.getCouId().toString(),true,true,true);
            Field name =  new Field("name",course.getCouName(),true,true,true);
            Field Eval = new Field("Eval",course.getCouEval().toString(),true,true,true);
            Field EvalAmount = new Field("EvalAmount",course.getCouEvalAmount().toString(),true,true,true);
            Field AttendAmount = new Field("AttendAmount",course.getCouAttendAmount().toString(),true,true,true);
            Field school = new Field("school",course.getCouName(),true,true,true);

            document.add(id);
            document.add(name);
            document.add(school);
            document.add(Eval);
            document.add(EvalAmount);
            document.add(AttendAmount);
            doclist.add(document);
        }
        Analyzer analyzer= new StandardAnalyzer();

        File indexFile = new File("D:/LueneIndex/index");
        Directory directory = FSDirectory.getDirectory(indexFile, true);
        IndexWriter writer = new IndexWriter(directory, analyzer,true);


        for(Document doc: doclist) {
            writer.addDocument(doc);
        }
    }


}
