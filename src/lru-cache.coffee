( ->

  createNode = (data, pre = null, next = null) -> {data, pre, next}

  class DoubleLinkedList
    constructor:  ->
      @headNode = @tailNode = null

    remove: (node) ->
      if node.pre
        node.pre = node.next
      else
        @headNode = node.next

      if node.next
        node.next.pre = node.pre
      else
        @tailNode = node.pre

    insertBeginning: (node) ->
      if @headNode
        node.next = @headNode
        @headNode.pre = node
        @headNode = node
      else
        @headNode = @tailNode = node

    moveToHead: (node) ->
      @remove node
      @insertBeginning node

    clear: ->
      @headNode = @tailNode = null


  class LRUCache
    constructor: (@capacity = 10, @maxAge = 60000) ->
      @linkList = new DoubleLinkedList()
      @reset()

    keys: ->
      return Object.keys @hash


    values: ->
      @keys().map (key) =>
        @hash[key].data.value


    remove: (key) ->
      if @hash[key]?
        node = @hash[key]
        @linkList.remove node
        delete @hash[key]
        if node.data.onDispose then node.data.onDispose.call this, node.data.key, node.data.value
        @size--

    reset: ->
      @hash = {}
      @size = 0
      @linkList.clear()

    set: (key, value, onDispose) ->
      node = @hash[key]
      if node
        node.data.value = value
        node.data.onDispose = onDispose
        @_refreshNode node
      else
        if @size is @capacity then @remove @linkList.tailNode.data.key

        node = createNode {key, value, onDispose}
        node.data.lastVisitTime = Date.now()
        @linkList.insertBeginning node
        @hash[key] = node
        @size++

    get: (key) ->
      node = @hash[key]
      if !node? or @_isExpiredNode node
        return undefined
      @_refreshNode node
      return node.data.value

    _refreshNode: (node) ->
      node.lastVisitTime = Date.now()
      @linkList.moveToHead node

    _isExpiredNode: (node) ->
      return Date.now() - node.data.lastVisitTime > @maxAge

    has: (key) -> return @hash[key]?


  if typeof module is 'object' and module.exports
    module.exports = LRUCache
    console.log 'module.exports =', module.exports
  else
    this.LRUCache = LRUCache
)()