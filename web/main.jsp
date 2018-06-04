<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>网上课堂搜索</title>
<script src="js/jquery-3.3.1.js"></script>
<script src="js/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" href="css/materialize.min.css">
<style>
@import url("https://fonts.googleapis.com/css?family=Montserrat:200,300,400,600");
.more-pens {
  position: fixed;
  left: 20px;
  bottom: 20px;
  z-index: 10;
  font-family: "Montserrat";
  font-size: 12px;
}

a.white-mode, a.white-mode:link, a.white-mode:visited, a.white-mode:active {
  font-family: "Montserrat";
  font-size: 12px;
  text-decoration: none;
  background: #212121;
  padding: 4px 8px;
  color: #f7f7f7;
}
a.white-mode:hover, a.white-mode:link:hover, a.white-mode:visited:hover, a.white-mode:active:hover {
  background: #edf3f8;
  color: #212121;
}

body {
  margin: 0;
  padding: 0;
  overflow: hidden;
  width: 100%;
  height: 100%;
  background: #000000;
}

.title {
  z-index: 10;
  position: absolute;
  left: 50%;
  top: 50%;
  transform: translateX(-50%) translateY(-50%);
  font-family: "Montserrat";
  text-align: center;
  width: 100%;
}
.title h1 {
  position: relative;
  color: #EEEEEE;
  font-weight: 600;
  font-size: 60px;
  padding: 0;
  margin: 0;
  line-height: 1;
  text-shadow: 0 0 30px #000155;
}
.title h1 span {
  font-weight: 600;
  padding: 0;
  margin: 0;
  color: #BBB;
}
.title h3 {
  font-weight: 200;
  font-size: 20px;
  padding: 0;
  margin: 0;
  line-height: 1;
  color: #EEEEEE;
  letter-spacing: 2px;
  text-shadow: 0 0 30px #000155;
}
</style>
<script>
 function a(){
	let a=document.getElementById("autocomplete-input").value;
	$.ajax({
        type: "GET",
        url: "http://localhost:28080/materialize/data",
        data: {ha:a},
        success:function(data){
        	$.parseJSON(data);
        	for(x in data){
        		$("#result").append($("<div></div>"))
        		$("#result").empty()
        	}
        }
    });
 
	}  
/* 	function a(){
		 location.href="search.jsp"
	} */
</script>
</head>
<body>   
<div class="title">
   <div class="row">
   <div class="container">
   <h1 class="center-align flow-text">寻找课程</h1>
    <div class="col s12">
      <div class="row">
      <form action="data" method="GET">
        <div class="col s1 valign-wrapper" style> 
         <a class="btn-floating btn-large waves-effect waves-light gerrn"><i class="material-icons">CHZ</i></a>
        </div>
        <div class="input-field col s11">
          <input name="ha" type="text" id="autocomplete-input" class="autocomplete white-text text-darken-2">
          <label for="autocomplete-input">输入关键词</label>   
        </div>
        <div class="input-field col s10"> 
        </div>
        <div class="input-field col s2">               
            <button class="btn waves-effect waves-light" type="submit" name="action">Search
            <i class="material-icons right" ">GO</i>           
            </button>
        </a>
        </div>
      </form>      
     </div>
          </div>
        </div>
      </div>
    </div>
  </div><script>
let max_particles    = 100;
let particles        = [];
let frequency        = 100;
let init_num         = max_particles;
let max_time         = frequency*max_particles;
let time_to_recreate = false;

// Enable repopolate
setTimeout(function(){
  time_to_recreate = true;
}.bind(this), max_time)

// Popolate particles
popolate(max_particles);

var tela = document.createElement('canvas');
    tela.width = $(window).width();
    tela.height = $(window).height();
    $("body").append(tela);

var canvas = tela.getContext('2d');

class Particle{
  constructor(canvas, options){
    let colors = ["#feea00","#a9df85","#5dc0ad", "#ff9a00","#fa3f20"]
    let types  = ["full","fill","empty"]
    this.random = Math.random()
    this.canvas = canvas;
    this.progress = 0;

    this.x = ($(window).width()/2)  + (Math.random()*200 - Math.random()*200)
    this.y = ($(window).height()/2) + (Math.random()*200 - Math.random()*200)
    this.w = $(window).width()
    this.h = $(window).height()
    this.radius = 1 + (8*this.random)
    this.type  = types[this.randomIntFromInterval(0,types.length-1)];
    this.color = colors[this.randomIntFromInterval(0,colors.length-1)];
    this.a = 0
    this.s = (this.radius + (Math.random() * 1))/10;
    //this.s = 12 //Math.random() * 1;
  }

  getCoordinates(){
    return {
      x: this.x,
      y: this.y
    }
  }

  randomIntFromInterval(min,max){
      return Math.floor(Math.random()*(max-min+1)+min);
  }

  render(){
    // Create arc
    let lineWidth = 0.2 + (2.8*this.random);
    let color = this.color;
    switch(this.type){
      case "full":
        this.createArcFill(this.radius, color)
        this.createArcEmpty(this.radius+lineWidth, lineWidth/2, color)
      break;
      case "fill":
        this.createArcFill(this.radius, color)
      break;
      case "empty":
        this.createArcEmpty(this.radius, lineWidth, color)
      break;
    }
  }

  createArcFill(radius, color){
    this.canvas.beginPath();
    this.canvas.arc(this.x, this.y, radius, 0, 2 * Math.PI);
    this.canvas.fillStyle = color;
    this.canvas.fill();
    this.canvas.closePath();
  }

  createArcEmpty(radius, lineWidth, color){
    this.canvas.beginPath();
    this.canvas.arc(this.x, this.y, radius, 0, 2 * Math.PI);
    this.canvas.lineWidth = lineWidth;
    this.canvas.strokeStyle = color;
    this.canvas.stroke();
    this.canvas.closePath();
  }

  move(){

    this.x += Math.cos(this.a) * this.s;
    this.y += Math.sin(this.a) * this.s;
    this.a += Math.random() * 0.4 - 0.2;

    if(this.x < 0 || this.x > this.w - this.radius){
      return false
    }

    if(this.y < 0 || this.y > this.h - this.radius){
      return false
    }
    this.render()
    return true
  }

  calculateDistance(v1, v2){
    let x = Math.abs(v1.x - v2.x);
    let y = Math.abs(v1.y - v2.y);
    return Math.sqrt((x * x) + (y * y));
  }
}

/*
 * Function to clear layer canvas
 * @num:number number of particles
 */
function popolate(num){
  for (var i = 0; i < num; i++) {
   setTimeout(
     function(x){
       return function(){
         // Add particle
         particles.push(new Particle(canvas))
       };
     }(i)
     ,frequency*i);
  }
  return particles.length
 }

function clear(){
  // canvas.globalAlpha=0.04;
  canvas.fillStyle='#111111';
  canvas.fillRect(0, 0, tela.width, tela.height);
  // canvas.globalAlpha=1;
}

function connection(){
  let old_element = null
  $.each(particles, function(i, element){
    if(i>0){
      let box1 = old_element.getCoordinates()
      let box2 = element.getCoordinates()
      canvas.beginPath();
      canvas.moveTo(box1.x,box1.y);
      canvas.lineTo(box2.x,box2.y);
      canvas.lineWidth = 0.45;
      canvas.strokeStyle="#3f47ff";
      canvas.stroke();
      canvas.closePath();
    }

    old_element = element
  })
}

/*
 * Function to update particles in canvas
 */
function update(){
  clear();
  connection()
  particles = particles.filter(function(p) { return p.move() })
  // Recreate particles
  if(time_to_recreate){
    if(particles.length < init_num){ popolate(1);}
  }
  requestAnimationFrame(update.bind(this))
}

update()
</script>
<script src="js/materialize.min.js"></script>
<script src="js/materialize.js"></script> 
  <script type="text/javascript">
    $(document).ready(function(){
    $('input.autocomplete').autocomplete({
      data: {
    	  "艺术教育":null,
    	  "会计学原理":null,
    	  "“互联网+”管理学":null,
    	  "大学物理典型问题解析—振动、波动与光学":null,
    	  "大学物理典型问题解析—电磁学":null,
    	  "大学物理典型问题解析—近代物理":null,
    	  "大学物理典型问题解析—力学与热学":null,
    	  "应用光学":null,
    	  "数学实验":null,
    	  "线性代数习题选讲":null,
    	  "工程流体力学":null,
    	  "生命科学基础":null,
    	  "Python网络爬虫与信息提取":null,
    	  "Python数据分析与展示":null,
    	  "Python科学计算三维可视化":null,
    	  "Python云端系统开发入门":null,
    	  "Python机器学习应用":null,
    	  "Python游戏开发入门":null,
    	  "计算机辅助设计：参数化造型设计及表达":null,
    	  "零基础学Python语言CAP":null,
    	  "数学竞赛选讲":null,
    	  "大学计算机CAP":null,
    	  "C语言程序设计(上)CAP":null,
    	  "基础免疫学":null,
    	  "微积分（一）":null,
    	  "微电子电路基础":null,
    	  "C语言程序设计(上)":null,
    	  "大学物理—电磁学":null,
    	  "Python语言程序设计":null,
    	  "线性代数":null,
    	  "大学物理—近代物理":null,
    	  "大学物理—力学与热学":null,
    	  "大学物理—振动、波动与光学":null,
    	  "C语言程序设计（下）":null,
    	  "机械制图及数字化表达":null,
    	  "微积分(二)":null,
    	  "工程图基础及数字化构型":null,
    	  "大学计算机":null,
    	  "管理运筹学":null,
    	  "机械原理":null,
    	  "速成汉语语法课堂":null,
    	  "初级汉语语法":null,
    	  "经济学原理":null,
    	  "古诗今读":null,
    	  "西方文学经典鉴赏":null,
    	  "环境污染事件与应急响应":null,
    	  "环境科学概论之行动篇":null,
    	  "中学化学教学设计与实践":null,
    	  "中国传世名画鉴赏":null,
    	  "循环经济与可持续发展型企业":null,
    	  "网络信息计量与评价":null,
    	  "环境规划":null,
    	  "城市生态规划":null,
    	  "教学论":null,
    	  "语文课程标准与教材研究":null,
    	  "创造性心理学":null,
    	  "管理学":null,
    	  "遥感数字图像处理":null,
    	  "世界文明专题（古代部分）":null,
    	  "理论力学":null,
    	  "《左传 》专题研究":null,
    	  "莎士比亚戏剧赏析":null,
    	  "恢复生态学":null,
    	  "史学名家的治史历程与方法":null,
    	  "历代青花画法":null,
    	  "中学数学课程标准与教材研究":null,
    	  "固体废物处置与资源化":null,
    	  "魅力语言学":null,
    	  "儒家经典文献导读":null,
    	  "文献学的理论与方法":null,
    	  "机械原理学习指导与习题解析":null,
    	  "工科数学分析（一）":null,
    	  "航空燃气涡轮发动机结构设计":null,
    	  "工科数学分析（二）":null,
    	  "数字信号处理":null,
    	  "微波技术":null,
    	  "数学眼光看道家":null,
    	  "线性代数启蒙":null,
    	  "微积分启蒙":null,
    	  "机械原理":null,
    	  "航空航天概论":null,
    	  "中药安全用药导论":null,
    	  "针灸学导论":null,
    	  "中医诊断学（上）":null,
    	  "化工原理（上）":null,
    	  "化工原理（下）":null,
    	  "化工过程分析与合成":null,
    	  "仪器分析":null,
    	  "材料导论":null,
    	  "物理化学（上）":null,
    	  "复杂物质剖析":null,
    	  "现代煤化工概论":null,
    	  "管理学":null,
    	  "有机化学":null,
    	  "有机化学分子建模":null,
    	  "过程设备设计":null,
    	  "通信原理":null,
    	  "英美诗歌名篇选读":null,
    	  "C语言程序设计——快速入门与提高CAP":null,
    	  "大学计算机基础CAP":null,
    	  "大学计算机基础":null,
    	  "C语言程序设计——快速入门与提高":null,
    	  "信息安全概论":null,
    	  "C++语言程序设计（上）":null,
    	  "画法几何与技术制图基础":null,
    	  "C++语言程序设计（下）——从C到C++":null,
    	  "计算机图形学":null,
    	  "创造你的音乐生活——大学音乐指南":null,
    	  "强歌声乐课堂":null,
    	  "比较文学":null,
    	  "诺贝尔生理学或医学奖史话":null,
    	  "数字化教师信息技术素养":null,
    	  "环境与健康":null,
    	  "习字与书法艺术":null,
    	  "文学经典导读":null,
    	  "新闻伦理与法规":null,
    	  "心理学：我知无不言，它妙不可言":null,
    	  "中学生物学教学设计":null,
    	  "管理的艺术":null,
    	  "世界三大宗教与艺术":null,
    	  "生活中的自制乐器与演奏":null,
    	  "西方音乐史(下)":null,
    	  "中国古代音乐史":null,
    	  "学校音乐教育新体系——小学音乐课程示范教学":null,
    	  "工尺谱概论":null,
    	  "西方音乐史(上)":null,
    	  "教师职业道德":null,
    	  "中药学":null,
    	  "单片机原理与汽车微机应用技术":null,
    	  "网络视频监控技术":null,
    	  "交通规划":null,
    	  "制造过程故障诊断技术":null,
    	  "机械原理":null,
    	  "互换性与技术测量":null,
    	  "选矿学":null,
    	  "工程机械构造":null,
    	  "液压传动":null,
    	  "工程材料":null,
    	  "高级物流学":null,
    	  "创业基础":null,
    	  "组织学与胚胎学":null,
    	  "人体解剖学":null,
    	  "博弈论":null,
    	  "教师信息技术应用能力提升":null,
    	  "电路分析":null,
    	  "药物化学":null,
    	  "中药与美容":null,
    	  "药物分析":null,
    	  "工业药剂学":null,
    	  "生物制药工艺学（技术与基础）":null,
    	  "电子商务":null,
    	  "概率论与数理统计":null,
    	  "结构力学":null,
    	  "新大学英语·阅读与思辨（上）":null,
    	  "新大学英语·阅读与思辨（下）":null,
    	  "地学景观探秘·审美·文化":null,
    	  "客户关系管理":null,
    	  "卡通说解数字电子技术":null,
    	  "数学实验":null,
    	  "物理-力学CAP":null,
    	  "大学化学(上)":null,
    	  "大学化学（下）":null,
    	  "中国近现代史纲要":null,
    	  "食物营养与食品安全":null,
    	  "大学生安全文化":null,
    	  "软件度量及应用":null,
    	  "数字电子技术":null,
    	  "生理学":null,
    	  "大学英语—交互英语（一）":null,
    	  "科学计算与数学建模":null,
    	  "大学英语—交互英语（二）":null,
    	  "科学计算与MATLAB语言":null,
    	  "材料力学":null,
    	  "电工学":null,
    	  "大学生心理健康教育":null,
    	  "知识产权法":null,
    	  "分子生物学":null,
    	  "矿井通风与空气调节":null,
    	  "创业团队建设与管理":null,
    	  "创业融资":null,
    	  "投资学":null,
    	  "市场营销学":null,
    	  "互联网金融概论":null,
    	  "金融学（一）":null,
    	  "金融学（二）":null,
    	  "周口店野外地质实践教学":null,
    	  "金属材料及热处理":null,
    	  "零基础学C语言":null,
    	  "结晶学及矿物学":null,
    	  "分析化学":null,
    	  "水文地质学基础":null,
    	  "说话与倾听":null,
    	  "Office高级应用":null,
    	  "走近数学——数学建模篇":null,
    	  "法学方法论":null,
    	  "异化劳动和异化消费概论":null,
    	  "作业系统":null,
    	  "神经网络和深度学习":null,
    	  "改善深层神经网络：超参数调试、正则化以及优化":null,
    	  "结构化机器学习项目":null,
    	  "信息系统与数据库技术":null,
    	  "环境监测":null,
    	  "金融风险管理":null,
    	  "Matlab数学实验":null,
    	  "海上货物运输":null,
    	  "航海力学":null,
    	  "海商法":null,
    	  "航运管理":null,
    	  "轮机自动化":null,
    	  "船舶防火与灭火":null,
    	  "航海英语听力与会话":null,
    	  "漫话天文航海":null,
    	  "实用绳结技术":null,
    	  "船舶避碰与值班":null,
    	  "宇宙探索与发现":null,
    	  "现代科技与人类未来":null,
    	  "化学与社会CAP":null,
    	  "无机化学（上）":null,
    	  "物理化学（一）":null,
    	  "物理化学（二）":null,
    	  "现代工程制图（上）":null,
    	  "脑洞大开背后的创新思维":null,
    	  "IT行业职场英语":null,
    	  "计算机组织与结构":null,
    	  "现代工程制图（下）":null,
    	  "分析化学":null,
    	  "无机化学（下）":null,
    	  "粉体力学":null,
    	  "大学物理—相对论、电磁学":null,
    	  "大学物理—量子物理基础及应用":null,
    	  "大学物理—光学":null,
    	  "大学物理—力学、振动与波动":null,
    	  "大学计算机":null,
    	  "材料科学基础":null,
    	  "C语言程序设计":null,
    	  "材料力学":null,
    	  "电工技术（电工学 上）":null,
    	  "化工过程分析与合成":null,
    	  "力学A":null,
    	  "流体力学":null,
    	  "体育舞蹈与文化":null,
    	  "创业基础与实务":null,
    	  "结构力学——静定结构力学":null,
    	  "理论力学":null,
    	  "家庭理财":null,
    	  "社会调查与统计分析":null,
    	  "脑洞大开背后的创新方法":null,
    	  "工程力学——静力学":null,
    	  "工程力学——材料力学":null,
    	  "化工原理（上册）":null,
    	  "化工原理（下册）":null,
    	  "结构力学——超静定结构力学":null,
    	  "水利工程施工":null,
    	  "画法几何及土木工程制图（上）":null,
    	  "电子技术（电工学 下）":null,
    	  "画法几何及土木工程制图（下）":null,
    	  "数字电路与系统":null,
    	  "嵌入式软件设计":null,
    	  "有机化学（下）":null,
    	  "有机化学（上）":null,
    	  "普通化学":null,
    	  "化学与社会":null,
    	  "计量地理学":null,
    	  "经济地理学":null,
    	  "民族声乐进阶密码——石春轩子教学示范课堂":null,
    	  "数学分析（二）":null,
    	  "数学分析（四）":null,
    	  "数学分析（三）":null,
    	  "环境问题观察":null,
    	  "数学分析（五）":null,
    	  "信息化教学设计":null,
    	  "数学分析（六）":null,
    	  "网球技术与战术":null,
    	  "电子技术综合实践":null,
    	  "中国智慧":null,
    	  "人文地理学":null,
    	  "人体科学":null,
    	  "冷战史专题":null,
    	  "波动光学":null,
    	  "数学分析（一）":null,
    	  "体育与健康":null,
    	  "形势与政策":null,
    	  "大学生劳动就业法律问题解读":null,
    	  "文献检索":null,
    	  "书法学堂":null,
    	  "生物大数据":null,
    	  "生态文明——撑起美丽中国梦":null,
    	  "中国古典家具":null,
    	  "匠心与创新——家具行业创新创业":null,
    	  "营养与健康讲座":null,
    	  "家畜寄生虫病学":null,
    	  "现代仪器分析":null,
    	  "生态学":null,
    	  "外经贸英语函电":null,
    	  "农业植物病理学":null,
    	  "茶韵茶魂—安溪铁观音":null,
    	  "大学信息技术基础":null,
    	  "走进性科学":null,
    	  "生活药学":null,
    	  "中学语文名篇选讲":null,
    	  "数字时代的学习技术":null,
    	  "运动生物力学":null,
    	  "文化创意产业":null,
    	  "文采风流：近现代闽籍文人与作家":null,
    	  "中学化学实验及实验教学研究":null,
    	  "地球概论":null,
    	  "C语言程序设计":null,
    	  "离散数学":null,
    	  "网络安全与应用":null,
    	  "大学计算机——医学计算基础":null,
    	  "全球卫生导论":null,
    	  "卫生技术评估":null,
    	  "儿科学":null,
    	  "预防医学（二）":null,
    	  "预防医学（一）":null,
    	  "《新教伦理与资本主义精神》导读":null,
    	  "抗菌药与超级细菌——天使与魔鬼的博弈":null,
    	  "病原生物与人类":null,
    	  "海洋与人类文明的生产":null,
    	  "电器理论基础":null,
    	  "大学生职业发展与就业指导":null,
    	  "地下结构数值计算方法":null,
    	  "理论力学":null,
    	  "财务报表编制":null,
    	  "市场营销学":null,
    	  "孙子兵法鉴赏":null,
    	  "一元函数微积分":null,
    	  "会计学原理":null,
    	  "品牌管理":null,
    	  "分析化学":null,
    	  "新型陶瓷材料与商业应用":null,
    	  "药物化学":null,
    	  "食品化学":null,
    	  "大学生心理健康教育":null,
    	  "海绵城市建设理念与工程应用":null,
    	  "材料性能与应用":null,
    	  "材料物理性能与结构表征实验":null,
    	  "陶瓷工艺学":null,
    	  "创业之路——带你玩转商业模式":null,
    	  "市场营销英语":null,
    	  "交替传译":null,
    	  "计算思维的结构":null,
    	  "计算机科学导论":null,
    	  "马克思主义民族理论与政策":null,
    	  "教学动画制作与实战":null,
    	  "教育行业创业":null,
    	  "小学语文教学设计":null,
    	  "计算机网络自学笔记":null,
    	  "中学教育见习与实习":null,
    	  "模拟电子技术基础":null,
    	  "形势与政策":null,
    	  "思想道德修养与法律基础":null,
    	  "德育原理":null,
    	  "中国书法":null,
    	  "大学生健康教育":null,
    	  "云计算技术与应用":null,
    	  "钢结构":null,
    	  "水利工程概论":null,
    	  "水工钢筋混凝土结构学":null,
    	  "大数据算法":null,
    	  "物理光学":null,
    	  "天线原理":null,
    	  "大学生职业能力拓展":null,
    	  "中国传统艺术——篆刻、书法、水墨画体验与欣赏":null,
    	  "沟通心理学":null,
    	  "数据库系统（上）：模型与语言":null,
    	  "理论力学":null,
    	  "中级财务会计（一）":null,
    	  "材料力学":null,
    	  "概率论与数理统计":null,
    	  "计算机组成原理（下）":null,
    	  "数据库系统（中）：建模与设计":null,
    	  "管理沟通：思维与技能":null,
    	  "高等数学习题课（二）":null,
    	  "数据库系统（下）：管理与技术":null,
    	  "程序设计基础CAP":null,
    	  "微积分CAP":null,
    	  "高级语言程序设计（Python）CAP":null,
    	  "大学计算机—计算思维导论CAP":null,
    	  "成功心理与人才发展":null,
    	  "建筑设计空间基础认知":null,
    	  "新科学家英语：演讲与写作":null,
    	  "结构动力学":null,
    	  "诺奖作家英文作品赏析":null,
    	  "中级财务会计（二）":null,
    	  "水分析化学":null,
    	  "电路（上）":null,
    	  "电工学":null,
    	  "互换性与测量技术基础":null,
    	  "生活心理学":null,
    	  "无机化学CAP":null,
    	  "线性代数与空间解析几何":null,
    	  "编译原理":null,
    	  "创业3+3":null,
    	  "数学竞赛选讲":null,
    	  "大学物理Ⅱ——热学":null,
    	  "自我塑造：优雅做人":null,
    	  "道路交通环境保护":null,
    	  "嵌入式系统原理及应用":null,
    	  "电机学":null,
    	  "设计之美":null,
    	  "数字逻辑设计":null,
    	  "机械基础实景教学（机械原理）":null,
    	  "机械基础实景教学（机械设计）":null,
    	  "操作系统":null,
    	  "电磁场":null,
    	  "会计学基础":null,
    	  "电力电子技术":null,
    	  "自我认知与情绪管理":null,
    	  "传感技术及应用":null,
    	  "中级财务会计（三）":null,
    	  "电路(下)":null,
    	  "微积分（一）":null,
    	  "国际交流英语":null,
    	  "无机化学——化学反应原理":null,
    	  "自我塑造：成功五要素":null,
    	  "微电子工艺":null,
    	  "大学物理(力学、振动和波、相对论)":null,
    	  "计算机网络":null,
    	  "无机化学——物质结构基础":null,
    	  "微积分（二）":null,
    	  "数字电子技术基础":null,
    	  "微积分（三）":null,
    	  "软件工程专业导论":null,
    	  "计算机组成原理（上）":null,
    	  "单片机原理及应用":null,
    	  "算法设计与分析入门":null,
    	  "微积分（四）":null,
    	  "高等数学习题课（一）":null,
    	  "计算机专业导论":null,
    	  "程序设计基础":null,
    	  "C语言程序设计精髓":null,
    	  "大学计算机—计算思维导论":null,
    	  "高级语言程序设计（Python）":null,
    	  "《论语》人生课堂":null,
    	  "婚姻家庭法":null,
    	  "设计的力量CAP":null,
    	  "中国古代建筑艺术CAP":null,
    	  "从自然世界到智能时代":null,
    	  "分析化学（一）：化学分析":null,
    	  "广告创意学":null,
    	  "分析化学（二）：仪器分析":null,
    	  "分析化学（三）：波谱分析":null,
    	  "国际金融学":null,
    	  "“互联网+”时代的颠覆与创新":null,
    	  "交互数字媒体技术与设计":null,
    	  "设计心理学":null,
    	  "服务设计与商业模式":null,
    	  "设计创意学":null,
    	  "三维形式基础":null,
    	  "结构力学（上）":null,
    	  "生物材料伴我行":null,
    	  "混凝土结构设计原理":null,
    	  "数字通信原理":null,
    	  "互动图形基础":null,
    	  "钢结构设计原理":null,
    	  "学设计 做产品":null,
    	  "概率论与数理统计":null,
    	  "金融学":null,
    	  "防灾工程学":null,
    	  "基础化学实验（分析化学）":null,
    	  "激光加工创新训练":null,
    	  "基础化学实验（有机化学）":null,
    	  "人机工程学":null,
    	  "现代礼仪":null,
    	  "设计的力量":null,
    	  "中国古代建筑艺术":null,
    	  "科举与中国文化":null,
    	  "标准与我们的生活":null,
    	  "经济生活与数学":null,
    	  "互联网是如何工作的？":null,
    	  "组织行为与领导力":null,
    	  "立体构成——空间形态构成":null,
    	  "核反应堆物理":null,
    	  "弟子规与人生修炼":null,
    	  "现代市场营销素质与能力提升":null,
    	  "自动控制元件":null,
    	  "孙子兵法的智慧应用":null,
    	  "水声学":null,
    	  "军事理论":null,
    	  "物联网工程导论":null,
    	  "微波技术":null,
    	  "工业过程控制":null,
    	  "机械制造基础":null,
    	  "数学零距离":null,
    	  "机械制图":null,
    	  "运动与健康":null,
    	  "传统社会的婚姻家庭":null,
    	  "中国茶道":null,
    	  "植物生理学":null,
    	  "唐宋诗词与传统文化":null,
    	  "教育哲学":null,
    	  "英语演讲与辩论":null,
    	  "工程力学":null,
    	  "自动控制原理":null,
    	  "3D工程图学":null,
    	  "网络与新媒体应用模式":null,
    	  "天文漫谈":null,
    	  "寄生虫病与食品安全":null,
    	  "软件测试与质量":null,
    	  "数据结构":null,
    	  "数字电子技术基础":null,
    	  "自动控制原理（二）":null,
    	  "VB.NET程序设计":null,
    	  "有机化学":null,
    	  "电子线路设计、测试与实验（一）":null,
    	  "电子线路设计、测试与实验（二）":null,
    	  "复变函数与积分变换":null,
    	  "内科护理学":null,
    	  "护理科研":null,
    	  "模拟电子技术基础":null,
    	  "有机化学":null,
    	  "动物生理学":null,
    	  "数学文化欣赏":null,
    	  "无机及分析化学（上）":null,
    	  "普通昆虫学（一）":null,
    	  "无机及分析化学（下）":null,
    	  "数学建模":null,
    	  "认识星空":null,
    	  "中国饮食文化":null,
    	  "植物学":null,
    	  "应用写作":null,
    	  "普通昆虫学（二）":null,
    	  "魅力汉语":null,
    	  "经济学原理":null,
    	  "地质与地貌学":null,
    	  "园艺概论":null,
    	  "畜牧学概论":null,
    	  "宠物犬鉴赏":null,
    	  "生命科学导论":null,
    	  "线性代数":null,
    	  "公司理财":null,
    	  "动物组织胚胎学":null,
    	  "微生物学":null,
    	  "高等数学（一）":null,
    	  "美术鉴赏——中国传统绘画鉴赏":null,
    	  "理论力学（上）":null,
    	  "风景素描":null,
    	  "英国文学导读":null,
    	  "动物学":null,
    	  "花卉学":null,
    	  "微观经济学":null,
    	  "美食鉴赏与食品创新设计":null,
    	  "民俗文化鉴赏":null,
    	  "免疫学":null,
    	  "蘑菇概论":null,
    	  "高等数学（二）":null,
    	  "创意逐格动画":null,
    	  "茶叶加工学":null,
    	  "大学英语综合教程（初级）":null,
    	  "动物流行病学":null,
    	  "农药化学":null,
    	  "园林树木学":null,
    	  "水生生物学":null,
    	  "水族景观规划与设计":null,
    	  "农科大学物理":null,
    	  "外国文学史（一）":null,
    	  "外国文学史（二）":null,
    	  "会计学":null,
    	  "MIB国际商务":null,
    	  "投资与理财":null,
    	  "印象英美——穿越时空之旅":null,
    	  "英语教学与互联网":null,
    	  "课堂问答的智慧与艺术":null,
    	  "信息化领导力":null,
    	  "游戏化教学法":null,
    	  "交互式电子白板教学应用":null,
    	  "改进合作学习":null,
    	  "微课设计与制作":null,
    	  "走向深度的合作学习":null,
    	  "走进项目学习":null,
    	  "“互联网+”时代教师个人知识管理":null,
    	  "信息化教学能力之五项修炼":null,
    	  "课堂管理的方法与艺术":null,
    	  "思维导图的教学应用":null,
    	  "智慧课堂教学":null,
    	  "电子书包教学应用":null,
    	  "教师法律风险防范":null,
    	  "以学生为中心的学习环境设计":null,
    	  "动态几何画板Geogebra教学应用":null,
    	  "如何进行英语教学评价":null,
    	  "班主任的沟通艺术":null,
    	  "教师课堂教学技能的自我提升":null,
    	  "如何做创客教育":null,
    	  "面向核心素养的信息化教学设计":null,
    	  "微课程教学法":null,
    	  "教学研究的数据处理与工具应用":null,
    	  "MOOC大家谈":null,
    	  "创业：道与术":null,
    	  "职业：道与术":null,
    	  "机器人操作系统入门":null,
    	  "年轻人的第一堂就业指导课":null,
    	  "视觉保健康复技术":null,
    	  "跨越自然的“彩虹”—桥梁工程导论":null,
    	  "宝石加工工艺学":null,
    	  "探索“视”界——视光学与视觉科学导论":null,
    	  "工程图学（二）":null,
    	  "计算机网络技术":null,
    	  "大学英语过程写作":null,
    	  "物理学导论":null,
    	  "机械原理":null,
    	  "绿色康复":null,
    	  "微机原理与接口技术":null,
    	  "C语言程序设计":null,
    	  "私法英语表达":null,
    	  "西方现代艺术赏析":null,
    	  "西方文论原典导读":null,
    	  "工程图学（一）":null,
    	  "无机化学原理":null,
    	  "无机元素化学":null,
    	  "物理与人类生活":null,
    	  "奇异的仿生学":null,
    	  "汽车行走的艺术":null,
    	  "人文视野中的生态学":null,
    	  "高级语言程序设计":null,
    	  "力学(上)":null,
    	  "力学(下)":null,
    	  "创业企业法律问题面面观":null,
    	  "英语演讲":null,
    	  "中国古典舞与乐舞文化":null,
    	  "英语语法与句子写作":null,
    	  "数字营销：走进智慧的品牌":null,
    	  "中医与诊断—学做自己的医生":null,
    	  "英语语法与写作":null,
    	  "自然保护与生态安全：拯救地球家园":null,
    	  "英美概况——纵览·博闻":null,
    	  "生活中的物理学":null,
    	  "华文教学的理念与方法":null,
    	  "创业基础":null,
    	  "《红楼梦》的空间艺术":null,
    	  "智圆行方的世界——中国传统文化概论":null,
    	  "生活中的货币时间价值":null,
    	  "华文教育技术与实践":null,
    	  "国际私法":null,
    	  "法律人看婚姻家事":null,
    	  "中国特色社会主义理论与实践研究":null,
    	  "走近马克思":null,
    	  "民法与生活":null,
    	  "行政职业能力提升":null,
    	  "多元统计分析及R语言建模":null,
    	  "中医养生与亚健康防治":null,
    	  "理性色彩 智慧人生":null,
    	  "营商的法律智慧：商法":null,
    	  "细胞生物学：细胞社会的奥秘":null,
    	  "国际名酒知识与品鉴":null,
    	  "力学与现代生活——开启科学人生":null,
    	  "管理学原理":null,
    	  "管理咨询":null,
    	  "生物医药实验室安全知识":null,
    	  "轻松学统计":null,
    	  "中国税制":null,
    	  "国际金融":null,
    	  "保险理论与实务":null,
    	  "制胜：一部孙子傲商海":null,
    	  "会计学原理":null,
    	  "高级财务会计":null,
    	  "创业法学":null,
    	  "乐学软件工程":null,
    	  "运筹学":null,
    	  "创业概论":null,
    	  "C君带你玩编程":null,
    	  "生活中的市场营销学":null,
    	  "室内花草栽培技术与装饰布景":null,
    	  "走近核科学技术":null,
    	  "微软人工智能 - 服务和 API":null,
    	  "微软人工智能 - 深度学习框架和工具":null,
    	  "微软人工智能 - 数据分析平台":null,
    	  "微软人工智能 - 概览":null,
    	  "人工智能系列前沿课程":null,
    	  "微软亚洲研究院大数据系列讲座":null,
    	  "“二十一世纪的计算”学术研讨会":null,
    	  "唐史四讲":null,
    	  "中国少数民族神话赏析":null,
    	  "数学文化十讲CAP":null,
    	  "环境学基础":null,
    	  "诸子的智慧":null,
    	  "数学文化十讲":null,
    	  "大学语文":null,
    	  "人体骨与关节解剖学":null,
    	  "音乐与健康":null,
    	  "好玩的广告学":null,
    	  "自动化专业概论":null,
    	  "电子线路仿真设计与实验实例":null,
    	  "半导体元件物理":null,
    	  "创意学经济":null,
    	  "孙子兵法与企业经营":null,
    	  "浅论电子学":null,
    	  "现场生命急救知识与技能":null,
    	  "高等数学（一）":null,
    	  "高等数学（二）":null,
    	  "口腔探密":null,
    	  "人体解剖学":null,
    	  "无处不在——传染病":null,
    	  "医学免疫学":null,
    	  "工程制图":null,
    	  "探秘身边的材料--材料与社会":null,
    	  "现代汉语言语交际":null,
    	  "光影·光阴——早期中国电影漫谈系列":null,
    	  "女生穿搭技巧":null,
    	  "计算机组织与结构":null,
    	  "艺术的星空":null,
    	  "化学创造美好生活":null,
    	  "聪慧的源泉——数学导读":null,
    	  "数据库技术及应用":null,
    	  "文学经典导读":null,
    	  "音乐课堂教学课例评析与研究":null,
    	  "外国民商案例选读":null,
    	  "线性代数":null,
    	  "复变函数与积分变换":null,
    	  "英语语言学概论":null,
    	  "高等数学（一）":null,
    	  "理论力学":null,
    	  "采矿学":null,
    	  "钢琴弹奏基础":null,
    	  "机械原理":null,
    	  "资源经济学":null,
    	  "计算机控制系统":null,
    	  "社区管理学":null,
    	  "老子的人生智慧":null,
    	  "分析化学":null,
    	  "工业生态学":null,
    	  "大学物理（力学、振动波、热学、量子基础）":null,
    	  "大学物理（电磁学、光学、相对论）":null,
    	  "机械工程控制基础":null,
    	  "软件工程":null,
    	  "企业文化与商业伦理":null,
    	  "结构化学":null,
    	  "材料力学":null,
    	  "大学生心理健康漫谈":null,
    	  "书法课堂":null,
    	  "高等数学（二）":null,
    	  "物理与人类未来":null,
    	  "足球裁判法":null,
    	  "电工学":null,
    	  "跨文化交流":null,
    	  "可视化程序设计技术及应用":null,
    	  "冶金资源综合利用与环境保护":null,
    	  "数值分析":null,
    	  "文化管理学":null,
    	  "高级语言程序设计":null,
    	  "计算机硬件技术基础":null,
    	  "大学计算机--Python算法实践":null,
    	  "计算机组成原理":null,
    	  "人因工程学":null,
    	  "材料成形力学":null,
    	  "画法几何及机械制图":null,
    	  "中国文化英语讲":null,
    	  "创新基础与创新方法":null,
    	  "冶金学":null,
    	  "滑冰教程":null,
    	  "现代科学运算—MATLAB语言与应用":null,
    	  "通用英语（一）":null,
    	  "茶叶品鉴艺术":null,
    	  "植物学":null,
    	  "农业植物病理学":null,
    	  "作物育种学":null,
    	  "普通生态学":null,
    	  "兽医寄生虫学":null,
    	  "土地经济学":null,
    	  "生物统计学":null,
    	  "美在民间":null,
    	  "资源与环境经济学":null,
    	  "形势与政策":null,
    	  "民事诉讼法":null,
    	  "学前儿童健康教育":null,
    	  "先秦诸子精华":null,
    	  "大学计算机——计算思维之路CAP":null,
    	  "单片机原理与应用":null,
    	  "模拟电子技术":null,
    	  "数字信号处理":null,
    	  "微机原理与接口技术":null,
    	  "交通运输概论":null,
    	  "电路":null,
    	  "数字电子技术基础":null,
    	  "轨道车辆制造":null,
    	  "离散数学":null,
    	  "工程热力学":null,
    	  "电磁场与电磁波":null,
    	  "传感器原理及应用":null,
    	  "大学计算机——计算思维之路":null,
    	  "信号与系统":null,
    	  "计算机操作系统":null,
    	  "用Python玩转数据":null,
    	  "理解马克思":null,
    	  "结构生物化学":null,
    	  "心理学与生活":null,
    	  "学在南哲：哲学与哲人":null,
    	  "程序猿与攻城狮":null,
    	  "天文探秘":null,
    	  "走进地理学":null,
    	  "中国行政法原理及应用":null,
    	  "营养与健康":null,
    	  "计算机系统基础(一)：程序的表示、转换与链接":null,
    	  "走进创业":null,
    	  "思想道德修养与法律基础":null,
    	  "普通天文学":null,
    	  "大学英语学术阅读":null,
    	  "软件测试":null,
    	  "职业与创业胜任力":null,
    	  "手把手教你心理咨询：谈话的艺术":null,
    	  "计算机系统基础（二）：程序的执行和存储访问":null,
    	  "中国文化与当代中国":null,
    	  "走近中华优秀传统文化":null,
    	  "走进天文学":null,
    	  "基于Java的面向对象编程范式":null,
    	  "植物与人类":null,
    	  "英汉互译方法与技巧":null,
    	  "计算机系统基础(三)：异常、中断和输入/输出":null,
    	  "网络技术与应用":null,
    	  "电路分析基础":null,
    	  "模拟电子线路A":null,
    	  "数字信号处理":null,
    	  "通信原理":null,
    	  "计算机网络基础及应用":null,
    	  "中医儿科学":null,
    	  "中医护理学":null,
    	  "中医内科学":null,
    	  "大观与微观：红楼梦1-40回":null,
    	  "感觉与知觉":null,
    	  "微积分导论(一)":null,
    	  "计算机网络概论":null,
    	  "细胞神经科学":null,
    	  "投资学":null,
    	  "数据结构":null,
    	  "认知神经科学":null,
    	  "细读张爱玲":null,
    	  "物联网概论":null,
    	  "系统神经科学":null,
    	  "财务管理":null,
    	  "物理与艺术":null,
    	  "马克思主义基本原理概论":null,
    	  "航天、人文与艺术":null,
    	  "无人机设计导论":null,
    	  "大学计算机基础CAP":null,
    	  "大学英语（口语）CAP":null,
    	  "高等数学典型例题与解法（一）":null,
    	  "微积分CAP":null,
    	  "计算机原理（下）":null,
    	  "大学英语综合课程（二）":null,
    	  "大学英语综合课程(一)":null,
    	  "大学物理实验":null,
    	  "高等数学典型例题与解法（二）":null,
    	  "模拟电子技术基础":null,
    	  "漫谈数学与军事":null,
    	  "大学英语综合课程（四）":null,
    	  "大学英语综合课程（三）":null,
    	  "理论力学":null,
    	  "工程力学":null,
    	  "复变函数":null,
    	  "大学英文写作（一）":null,
    	  "大学英文写作（二）":null,
    	  "大学物理-电磁学":null,
    	  "大学计算机基础":null,
    	  "大学英语（口语）":null,
    	  "大学英文写作":null,
    	  "大学物理-力学和热学":null,
    	  "数字电子技术基础":null,
    	  "通信原理":null,
    	  "高等数学（四）":null,
    	  "计算机原理":null,
    	  "高等数学（二）":null,
    	  "高等数学（三）":null,
    	  "高等数学（五）":null,
    	  "概率论与数理统计":null,
    	  "大学物理-振动、波动和波动光学":null,
    	  "大学物理-相对论":null,
    	  "大学物理-量子物理":null,
    	  "高等数学（一）":null,
    	  "生活中的纠纷与解决":null,
    	  "管理沟通":null,
    	  "导引系统原理":null,
    	  "机械制造基础":null,
    	  "3D打印技术及应用":null,
    	  "理论力学":null,
    	  "现代控制理论基础":null,
    	  "金属材料学":null,
    	  "生物医学工程概论":null,
    	  "人体解剖生理学":null,
    	  "计算机编码与密码学":null,
    	  "电磁场与电磁波":null,
    	  "材料科学基础（下）":null,
    	  "材料科学基础（上）":null,
    	  "机械设计":null,
    	  "机械原理":null,
    	  "航空发动机燃烧学":null,
    	  "航天器控制原理":null,
    	  "C程序设计":null,
    	  "C#程序设计":null,
    	  "C++程序设计":null,
    	  "设施蔬菜栽培学":null,
    	  "食品标准与法规":null,
    	  "农业昆虫学":null,
    	  "有机化学":null,
    	  "动物营养学":null,
    	  "行政管理学":null,
    	  "植物学":null,
    	  "大学语文":null,
    	  "半导体物理学":null,
    	  "古籍版本鉴定":null,
    	  "逻辑学导论":null,
    	  "工程制图":null,
    	  "数据结构":null,
    	  "数学思想与文化":null,
    	  "食品化学":null,
    	  "职熵—大学生职业素养与能力提升":null,
    	  "求职OMG-大学生就业指导与技能开发":null,
    	  "营运资金管理":null,
    	  "做好专业选择题——高中生涯教育":null,
    	  "大学生爱国教育十讲":null,
    	  "创行-大学生创新创业实务":null,
    	  "电影鉴赏":null,
    	  "世界优秀影片赏析":null,
    	  "《道德经》的智慧启示":null,
    	  "《世说新语》的国学密码解析":null,
    	  "数据结构":null,
    	  "数据结构":null,
    	  "运筹学":null,
    	  "网络技术与应用":null,
    	  "程序设计与算法（一）C语言程序设计CAP":null,
    	  "c#程序设计":null,
    	  "程序设计与算法（二）算法基础":null,
    	  "Java程序设计":null,
    	  "流行病学基础（二）":null,
    	  "翻转课堂教学法1.5":null,
    	  "程序设计与算法（三）C++面向对象程序设计":null,
    	  "人工智能原理":null,
    	  "大学生瑜伽":null,
    	  "对称性与晶体结构基础":null,
    	  "算法设计与分析":null,
    	  "离散数学概论":null,
    	  "学习工程师":null,
    	  "计算概论与程序设计基础":null,
    	  "微积分基础":null,
    	  "社会调查与研究方法":null,
    	  "浪漫主义时代的欧洲音乐":null,
    	  "生物学概念与途径":null,
    	  "数据结构与算法":null,
    	  "健康评估":null,
    	  "质性研究方法":null,
    	  "人工智能实践：Tensorflow笔记":null,
    	  "政治学概论":null,
    	  "生物演化":null,
    	  "流行病学基础（一）":null,
    	  "翻转课堂教学法":null,
    	  "教师如何做研究":null,
    	  "慕课问道":null,
    	  "信息化教学设计":null,
    	  "教你如何做MOOC":null,
    	  "卫生体系学":null,
    	  "橡胶与人类":null,
    	  "化学与健康":null,
    	  "数据库系统概论（高级篇）":null,
    	  "数据库系统概论（新技术篇）":null,
    	  "数据库系统概论（基础篇）":null,
    	  "发现微积分":null,
    	  "《论语》教育智慧品绎":null,
    	  "小学课程设计与评价":null,
    	  "教学设计原理与方法":null,
    	  "侵权责任法总论：“侵权责任法专题讲座系列”第一辑":null,
    	  "工程经济学":null,
    	  "全球商务":null,
    	  "企业战略管理":null,
    	  "市场营销":null,
    	  "eye我所爱——呵护你的眼":null,
    	  "公司法":null,
    	  "急您所脊——呵护我们的脊柱":null,
    	  "工程估价":null,
    	  "管理沟通":null,
    	  "巴蜀文化":null,
    	  "现代企业物流":null,
    	  "管理思想史":null,
    	  "营销策划":null,
    	  "人力资源管理":null,
    	  "电子商务":null,
    	  "质量管理":null,
    	  "化妆品赏析与应用":null,
    	  "美国文化":null,
    	  "中国诗歌艺术":null,
    	  "政治伦理学":null,
    	  "女性学：女性精神在现代社会中的挑战":null,
    	  "新生研讨课":null,
    	  "医学伦理学":null,
    	  "生殖健康——“性”福学堂":null,
    	  "细胞生物学":null,
    	  "太极拳医学":null,
    	  "侵权责任法":null,
    	  "药用植物学":null,
    	  "大学计算机--计算思维的视角":null,
    	  "高等数学—微积分CAP":null,
    	  "生物信息学":null,
    	  "概率论与数理统计":null,
    	  "大学计算机实验":null,
    	  "大学生性健康修养":null,
    	  "辐射与防护":null,
    	  "设计史话":null,
    	  "数学竞赛选讲":null,
    	  "《史通》导读":null,
    	  "《文心雕龙》导读":null,
    	  "趣味生物学实验":null,
    	  "大众传播学":null,
        "Google": 'https://placehold.it/250x250'
      },
    });
  });
  </script>
</body>
</html>