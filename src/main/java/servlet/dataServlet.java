package servlet;

import Dao.CourseEntity;
import org.apache.lucene.document.Document;
import org.apache.lucene.index.DirectoryReader;
import org.apache.lucene.index.IndexReader;
import org.apache.lucene.queryparser.classic.ParseException;
import org.apache.lucene.queryparser.classic.QueryParser;
import org.apache.lucene.search.IndexSearcher;
import org.apache.lucene.search.Query;
import org.apache.lucene.search.ScoreDoc;
import org.apache.lucene.search.TopDocs;
import org.apache.lucene.store.Directory;
import org.apache.lucene.store.FSDirectory;
import org.springframework.core.env.SystemEnvironmentPropertySource;
import org.wltea.analyzer.lucene.IKAnalyzer;

import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class data
 */

public class dataServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public dataServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // TODO Auto-generated method stub
//        System.out.println(request.getQueryString());
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        HttpSession session=request.getSession();
        String key=request.getParameter("ha");
        System.out.println(key);
//        search
//      flag=0，默认精确为第一序列
        if(key.equals("")||key==null) key="nul";
        String flag=key.substring(key.length()-3,key.length());
        key=key.substring(0,key.length()-3);
        System.out.println("flag is "+flag+"  key is "+ key);
        //定义索引目录
//        Path path = FileSystems.getDefault().getPath("index");
        Path path= Paths.get("d:\\LueneIndex");
        Directory directory = null;
        try {
            directory = FSDirectory.open(path);
        } catch (IOException e) {
            e.printStackTrace();
        }
        //定义索引查看器
        IndexReader indexReader = null;
        try {
            indexReader = DirectoryReader.open(directory);
        } catch (IOException e) {
            e.printStackTrace();
        }
        //定义搜索器
        IndexSearcher indexSearcher = new IndexSearcher(indexReader);
        //搜索内容


        //搜索关键字
        String  keyWords = key;

        //分页信息
        Integer page = 1;
        Integer pageSize = 20;
        Integer start = (page-1) * pageSize;
        Integer end = start + pageSize;

        Query query = null;//模糊搜索
        try {
            if(flag.equals("SCH")){
                query = new QueryParser("school",new IKAnalyzer()).parse(keyWords);
            }else{
                query = new QueryParser("name",new IKAnalyzer()).parse(keyWords);
            }

        } catch (ParseException e) {
            e.printStackTrace();
        }

        //命中前10条文档
        TopDocs topDocs = null;//根据end查询
        try {
            topDocs = indexSearcher.search(query,end);
        } catch (IOException e) {
            e.printStackTrace();
        }

        Integer totalPage = ((topDocs.totalHits/ pageSize) ==0)
                ? topDocs.totalHits/pageSize
                : ((topDocs.totalHits / pageSize) +1);

        System.out.println("“"+ keyWords +"”搜索到"+ topDocs.totalHits
                + "条数据，页数："+ page +"/"+ totalPage);
        //打印命中数
        System.out.println("命中数："+topDocs.totalHits);
        //取出文档
        ScoreDoc[] scoreDocs = topDocs.scoreDocs;
        int length = scoreDocs.length> end ? end : scoreDocs.length;
        List<CourseEntity> courses = new ArrayList<CourseEntity>();
        //遍历取出数据
        for (int i = start;i < length;i++){
            ScoreDoc doc = scoreDocs[i];
            System.out.println("得分："+ doc.score);
            Document document = null;
            try {
                document = indexSearcher.doc(doc.doc);
            } catch (IOException e) {
                e.printStackTrace();
            }
            CourseEntity courseEntity=new CourseEntity();
//            System.out.println("ID:"+ document.get("id"));
            courseEntity.setCouId(document.get("id"));

//            System.out.println("name:"+document.get("name"));
            courseEntity.setCouName(document.get("name"));

//            System.out.println("Score:"+document.get("score"));
            if(flag.equals("MUL")){
                courseEntity.setCouScore(Double.valueOf(document.get("score"))*doc.score/50 );
            }else{
                courseEntity.setCouScore(Double.valueOf(document.get("score")) );
            }


//            System.out.println("school:"+document.get("school"));
            courseEntity.setCouSchool(document.get("school"));

//            System.out.println("Eval:"+document.get("Eval"));
            courseEntity.setCouEval(Double.valueOf(document.get("Eval")));

//            System.out.println("EvalAmount:"+document.get("EvalAmount"));
            courseEntity.setCouEvalAmount(Integer.valueOf(document.get("EvalAmount")));
//            System.out.println("AttendAmount:"+document.get("AttendAmount"));
            courseEntity.setCouAttendAmount(Integer.valueOf(document.get("AttendAmount")));
            System.out.println("-----------------------");
            courses.add(courseEntity);
        }

        //关闭索引查看器
        try {
            indexReader.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
        System.out.println(courses);

        if(flag.equals("CHZ")||flag.equals("MUL")||flag.equals("SCH")){
            Collections.sort(courses, new Comparator<CourseEntity>() {
                @Override
                public int compare(CourseEntity o1, CourseEntity o2) {
                    return  o2.getCouScore().compareTo(o1.getCouScore());
                }
            });
        }


        session.setAttribute("chz",courses);

        response.getWriter().append("Served at: ").append(request.getContextPath());
        response.sendRedirect("search.jsp");
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // TODO Auto-generated method stub
        doGet(request, response);
    }

}
