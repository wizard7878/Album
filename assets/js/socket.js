import {Socket} from "phoenix"

let socket = new Socket("/socket", {params: {token: window.userToken}})

socket.connect()

const createSocket = (albumId) => {
  let channel = socket.channel(`comments:${albumId}`, {})
  channel.join()
    .receive("ok", resp => { 
      console.log(resp)
      renderComments(resp.comments)
     })
    .receive("error", resp => { console.log("Unable to join", resp) })
    
    channel.on(`comments:${albumId}:new`,renderComment)

    document.querySelector("#btn").addEventListener('click',() => {
      const content = document.querySelector('#form-comment').value
      channel.push('comment:add',{content: content})
    })

}

function renderComment(event){ // render one comment
  const renderedComment = commentTemplate(event.comment)
  document.querySelector('.list-group').innerHTML += renderedComment
}

function commentTemplate(comment){
  let fullName = "Anonymous"
  if(comment.auth){
    fullName = comment.auth.fname + " " + comment.auth.lname
  }
  return `
  <li class="list-group-item list-group-item-secondary">
    ${comment.content}
    <div class="float-right">
    ${fullName}
    </div>
  <li>
`
}

function renderComments(comment){ // rendering serveral comments
  const rendredComments = comment.map(comment => {
    return commentTemplate(comment)
  })
  document.querySelector('.list-group').innerHTML = rendredComments.join('')
}




window.createSocket = createSocket

