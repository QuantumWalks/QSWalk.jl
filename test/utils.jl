
facts("Vertex test") do
  context("Vertex creation") do
    @fact Vertex([1,2,3]).linspace --> [1,2,3]
    @fact Vertex([1,2,3])() --> Vertex([1,2,3]).linspace
  end

  context("Basic Vertex functionality") do
    v = Vertex([3,4,5])
    v2 = Vertex([3,4,5])
    @fact v() --> [3,4,5]
    @fact hash(v) --> hash(v())
    @fact v --> v2
    @fact v[2] --> 4
    @fact length(v) --> 3
  end

  context("Error check") do
    @fact_throws ArgumentError Vertex([1,2,0])
  end
end

facts("Vertex set") do
  context("VertexSet creation") do
    @fact VertexSet([Vertex([1,2,3]),Vertex([4,5])])() --> [Vertex([1,2,3]),Vertex([4,5])]
    @fact VertexSet([Vertex([1,2,3]),Vertex([4,5])])() --> [Vertex([1,2,3]),Vertex([4,5])]
    @fact VertexSet([[1,2,3],[4,5]])() --> [Vertex([1,2,3]),Vertex([4,5])]
  end

  context("Basic VertexSet functionaliy") do
    vset = VertexSet([[1,2,3],[4,5]])
    vset2 = VertexSet([[1,2,3],[4,5]])
    @fact vset() -->[Vertex([1,2,3]),Vertex([4,5])]
    @fact vset --> vset2
    @fact vset[2] --> Vertex([4,5])
    @fact vset[[1,2]] --> vset()
    @fact length(vset) --> 2
  end

  context("Error Check") do
    @fact_throws ArgumentError VertexSet([Vertex([1,2,0])])
    @fact_throws ArgumentError VertexSet([Vertex([1,2,3]),Vertex([3,4])])
  end
end
