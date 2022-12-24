function getFigure(width, height, figure) {
    var Xcenter = width / 2
    var Ycenter = height /2
    var fildSize = 10
    var Xscale = width / fildSize
    var Yscale = height / fildSize
    var points = Array()
    var xStep = width / 6
    var yStep = height / 5
    var starAnglesNumb = 5
    var fullTurn = Math.PI * 2
    switch(figure)
    {
    case "ring":
        var pointsIn = Array()
        var pointsOut = Array()
        var deg = Math.PI / 360

        for(var point = 0; point <= fullTurn; point += deg){
            pointsOut.push([Math.cos(point) * Xcenter * 0.9 + Xcenter,
                           Math.sin(point) * Ycenter * 0.9 + Ycenter])
        }
        for(point = 0; point <= fullTurn; point += deg){
            pointsIn.push([Math.cos(point) * Xcenter * 0.7 + Xcenter,
                           Math.sin(point) * Ycenter * 0.7 + Ycenter])
        }
        points = {"in" : pointsIn, "out" : pointsOut}
        break
    case "star":
        var indent = Math.PI / starAnglesNumb
        for(point = 0; point < fullTurn; point += indent){
            points.push([Math.cos(point) * Xcenter * 0.9 + Xcenter,
                           Math.sin(point) * Ycenter * 0.9 + Ycenter])
            point += indent
            points.push([Math.cos(point) * Xcenter * 0.5 + Xcenter,
                           Math.sin(point) * Ycenter * 0.5 + Ycenter])
        }
        points.push([Math.cos(fullTurn) * Xcenter * 0.9 + Xcenter,
                     Math.sin(fullTurn) * Ycenter * 0.9 + Ycenter])
        break
    case "house":
        var pointsRoof = Array ([width / 2, Yscale],
                                [width - Xscale, height / 3],
                                [Xscale, height / 3],
                                [width / 2, Yscale]
                                )
        var pointsFacade = Array ([width / 4, height / 3],
                                  [width /4 * 3, height / 3],
                                  [width /4 * 3, height - Yscale],
                                  [width / 4, height - Yscale],
                                  [width / 4, height / 3]
                                  )
        var pointsDoor = Array ([width / 2, height / 2],
                                [width /4 * 3 - Xscale, height / 2],
                                [width /4 * 3 - Xscale, height - Yscale],
                                [width / 2, height - Yscale],
                                [width / 2, height / 2]

                                )
        points = {"roof" : pointsRoof, "facade" : pointsFacade, "door" : pointsDoor }
        break
    case "heart":
        points = Array ([2 * xStep, yStep],
                        [3 * xStep, 2 * yStep],
                        [4 * xStep, yStep],
                        [5 * xStep, 2 * yStep],
                        [3 * xStep, 4 * yStep],
                        [xStep, 2 * yStep],
                        [2 * xStep, yStep])
        break
    default:
        return undefined
    }

    return points
}
