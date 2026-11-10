import QtQuick 2.15

Canvas {
    id: canvas
    required property var mechanism
    onWidthChanged: requestPaint()
    onHeightChanged: requestPaint()
    onPaint: {
        var c = getContext("2d")
        c.reset()
        c.clearRect(0, 0, width, height)
        c.save()
        c.scale(width / 100, height / 140)
        var p = mechanism.profile
        var v = mechanism.value
        var open = mechanism.guardOpen
        function rect(x,y,w,h,fill,stroke) {
            c.fillStyle=fill; c.fillRect(x,y,w,h)
            if (stroke) { c.strokeStyle=stroke; c.lineWidth=1; c.strokeRect(x,y,w,h) }
        }
        function ellipse(x,y,rx,ry,fill,stroke) {
            c.beginPath(); c.ellipse(x-rx,y-ry,rx*2,ry*2)
            c.fillStyle=fill; c.fill()
            if (stroke) { c.strokeStyle=stroke; c.lineWidth=1; c.stroke() }
        }
        function line(x1,y1,x2,y2,color,w) {
            c.beginPath(); c.moveTo(x1,y1); c.lineTo(x2,y2)
            c.strokeStyle=color; c.lineWidth=w; c.stroke()
        }
        function text(t,x,y,size,color,angle) {
            if (!t) return
            c.save(); c.translate(x,y); c.rotate(angle || 0)
            c.font="bold "+size+"px Arial"; c.textAlign="center"; c.textBaseline="middle"; c.fillStyle=color
            var lines=String(t).split("\n")
            for (var k=0;k<lines.length;k++) c.fillText(lines[k],0,(k-(lines.length-1)/2)*(size+1),78)
            c.restore()
        }
        function screw(x,y) {
            ellipse(x,y,3,3,"#b4b4ac","#575955"); line(x-2,y+1,x+2,y-1,"#454844",0.8)
        }
        function lever(x,y,on,color,blade,offset,barrel) {
            ellipse(x,y,12,10,"#393a37","#c4c4b6")
            ellipse(x,y,9,7,"#a5a390","#454640")
            var end=y+(offset !== undefined ? offset : (on ? -22 : 16))
            line(x,y,x,end,"#6a6b63",8)
            line(x-1.5,y-1,x-1.5,end,"#dbd9c9",3)
            if (blade) {
                rect(x-7,end-10,14,25,"#252827","#777a73")
                line(x-5,end-7,x-5,end+12,"#555a55",1)
            } else if (barrel) {
                rect(x-6,end-9,12,22,"#616860","#b5b9a7")
                for (var rib=0;rib<5;rib++) line(x-5,end-6+rib*4,x+5,end-6+rib*4,"#91998b",0.7)
                ellipse(x,end-9,6,4,color,"#898f7f")
            } else ellipse(x,end,6,7,color,"#78786b")
        }
        function knob(x,y,r,color,angle,spokes) {
            c.save(); c.translate(x,y); c.rotate(angle)
            ellipse(0,0,r+3,r+3,"#494c47","#afafa0")
            if(spokes) {
                c.beginPath()
                for(var i=0;i<64;i++) {
                    var a=i*Math.PI/32; var rr=r+(i%8<4 ? 2 : -2)
                    if(i===0)c.moveTo(Math.cos(a)*rr,Math.sin(a)*rr)
                    else c.lineTo(Math.cos(a)*rr,Math.sin(a)*rr)
                }
                c.closePath();c.fillStyle=color;c.fill();c.strokeStyle="#62665f";c.stroke()
            } else ellipse(0,0,r,r,color,"#d1c6a0")
            rect(-r*0.8,-5,r*1.6,10,color,"#9a9c8f")
            screw(0,0);c.restore()
        }
        function bracket(color) {
            var top=open ? 9 : 43
            line(22,top,78,top,color,6)
            line(22,top,22,124,color,5);line(78,top,78,124,color,5)
            line(22,124,34,124,color,5);line(66,124,78,124,color,5)
            line(25,top-1,76,top-1,"#d3cdb0",1)
            screw(22,126);screw(78,126)
        }
        function coveredActuator() {
            if (p === "guardedButton") {
                ellipse(50,96,12,12,"#848b7c","#c7c9b9")
                ellipse(50,96,9,9,v ? "#202821" : "#3d493c","#1c251e")
                ellipse(50,96+(v ? 2 : 0),4,v ? 3 : 4,"#dadbc9")
            } else lever(50,96,v,p === "conditioner" ? "#dabd44" : "#e0d8b9",false)
        }

        if(p === "oxygenValve") {
            knob(50,71,32,"#252b29",v ? 0.6 : -0.5,true)
            ellipse(68,82,4,4,"#58b8df")
        } else if(p === "suitVent") {
            knob(50,70,27,"#c2a965",v ? 1.0 : -0.45,false)
            for(var j=0;j<24;j++) {
                var a=j*Math.PI/12
                line(50+Math.cos(a)*23,70+Math.sin(a)*23,50+Math.cos(a)*27,70+Math.sin(a)*27,"#8e7949",1)
            }
        } else if(p === "depressurization") {
            c.save();c.translate(30,75);c.rotate(v ? -0.65 : 0.65)
            rect(0,-5,62,10,"#a82d30","#e77b74")
            ellipse(0,0,21,21,"#aa3135","#e99b83");screw(0,0)
            c.restore()
        } else if(p === "ventilationSlider") {
            rect(37,9,26,122,"#575d58","#a3aaa1")
            rect(44,14,12,110,"#171d1b","#868d82")
            for(var n=0;n<3;n++) rect(40,21+n*44,20,2,"#a0a69b")
            var sy=25+v*44
            rect(25,sy-12,50,24,"#212825","#9ca398")
            rect(29,sy-9,42,18,"#39423c","#626e63")
            for(var f=0;f<5;f++)line(33+f*8,sy-7,33+f*8,sy+7,"#1b231f",1)
        } else if(p === "rdk52") {
            rect(5,18,90,105,"#282f2c","#9aa397")
            screw(11,24);screw(89,24);screw(11,117);screw(89,117)
            text("100% O2",73,36,9,"#e5e0c6")
            text("RDK-52",31,36,9,"#e5e0c6")
            lever(25,87,mechanism.emergencyOn,"#b6beb0",false)
            lever(75,87,mechanism.oxygen100,"#b6beb0",false)
            line(50,46,50,112,"#697366",1)
        } else if(p === "ad5a") {
            ellipse(50,76,32,33,"#40443e","#a4a697")
            var theta=-0.65+v*0.65
            knob(50,76,26,"#262e28",theta,true)
            line(50,76,50+Math.sin(theta)*25,76-Math.cos(theta)*25,"#e3ddbf",4)
        } else if(p === "fireControl") {
            c.save()
            if(mechanism.mirror) {c.translate(100,0);c.scale(-1,1)}
            ellipse(23,39,18,20,"#393d37","#aaa996")
            ellipse(23,39,14,16,mechanism.firePressed ? "#751c22" : "#b13539","#e06c5b")
            if(!mechanism.firePressed)ellipse(19,33,5,4,"#dc6f63")
            lever(68,100,v,"#dbd8ba",false)
            // The real cover is L shaped; the button and fuelstop remain independent.
            rect(56,7,29,open ? 24 : 112,"#272c29","#697067")
            c.beginPath()
            if(open) {c.moveTo(56,5);c.lineTo(85,5);c.lineTo(85,27);c.lineTo(8,27);c.lineTo(8,16);c.lineTo(56,16)}
            else {c.moveTo(56,17);c.lineTo(85,17);c.lineTo(85,115);c.lineTo(6,115);c.lineTo(6,72);c.lineTo(56,72)}
            c.closePath();c.fillStyle="#a53134";c.fill();c.strokeStyle="#e17b6a";c.lineWidth=1.6;c.stroke()
            rect(58,7,25,12,"#252b29","#62675f");screw(70,12)
            c.restore()
            if(!open)text(mechanism.labelText,mechanism.mirror ? 55 : 45,91,10,"#f0ead3")
        } else if(p === "reserveIntake" || p === "engineStart") {
            lever(50,94,v,p === "engineStart" ? "#3395be" : "#e5c132",false,[16,-22,0][v],true)
        } else if(p === "wingNose" || p === "pyroToggle") {
            lever(50,94,v,p === "pyroToggle" ? "#3395be" : "#e5c132",false,
                  p === "wingNose" ? [16,-22,0][v] : undefined)
            bracket(p === "wingNose" ? "#aba38b" : "#727a74")
            if(p === "wingNose") {
                rect(22,open ? 7 : 40,10,10,"#e8c22e")
                rect(68,open ? 7 : 40,10,10,"#e8c22e")
            }
        } else if(p === "sduTestToggle") {
            lever(50,95,v === 1,"#333b35",true,
                  mechanism.threePosition ? [0,-22,16][v] : undefined)
            rect(25,open ? 8 : 28,50,12,"#252d27","#7d8677")
            rect(22,32,8,91,"#242c26","#747d70")
            rect(70,32,8,91,"#242c26","#747d70")
            screw(27,125);screw(73,125)
        } else {
            coveredActuator()
            rect(25,6,50,119,"#242b27","#636d62")
            if(open) {
                rect(27,7,46,21,p === "conditioner" ? "#cfad37" : "#aa3437","#e29b76")
            } else {
                rect(29,19,42,100,p === "conditioner" ? "#cfad37" : "#aa3437","#e79d79")
                line(31,23,31,114,"#eed1a5",1)
                text(mechanism.labelText,50,70,10,p === "conditioner" ? "#22251f" : "#f3ecd5",-Math.PI/2)
            }
            rect(27,6,46,12,"#222923","#7d8575");screw(50,12)
            if(open)coveredActuator()
        }
        c.restore()
    }
}
