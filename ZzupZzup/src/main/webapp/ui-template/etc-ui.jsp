<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<jsp:include page="/layout/toolbar.jsp" />

<!-- start:해당 부분은 지우고 아래 container안에 작성 -->
<div class="row">
	<div class="col-12">
		<ul>
			<li><a href="/ui-template/basic-template.jsp">기본 템플릿</a></li>
			<li><a href="/ui-template/button.jsp">버튼</a></li>
			<li><a href="/ui-template/form.jsp">등록양식</a></li>
			<li><a href="/ui-template/form-view.jsp">등록양식 결과</a></li>
			<li><a href="/ui-template/thumbnail.jsp">썸네일리스트</a></li>
			<li><a href="/ui-template/list.jsp">일반리스트</a></li>
			<li><a href="/ui-template/carousel.jsp">슬라이드</a></li>
			<li><a href="/ui-template/table.jsp">테이블</a></li>
			<li><a href="/ui-template/etc-ui.jsp">기타ui</a></li>
		</ul>
	</div>
</div>
<!-- end -->

<div class="container">

	<!-- Elements -->
	<h2 id="elements">Elements</h2>
	<div class="row gtr-200">
		<div class="col-12">
			<h3>부트스트랩 참고</h3>
			<a href="https://getbootstrap.com/docs/4.6/components/alerts/"
				target="blank">부트스트랩 이동</a>
			<hr />
			<!-- Text stuff -->
			<h3>Text</h3>
			<p>
				This is <b>bold</b> and this is <strong>strong</strong>. This is <i>italic</i>
				and this is <em>emphasized</em>. This is <sup>superscript</sup> text
				and this is <sub>subscript</sub> text. This is <u>underlined</u> and
				this is code:
				<code>for (;;) { ... }</code>
				. Finally, this is a <a href="#">link</a>.
			</p>
			<hr />
			<h2>Heading Level 2</h2>
			<h3>Heading Level 3</h3>
			<h4>Heading Level 4</h4>
			<hr />
			<p>Nunc lacinia ante nunc ac lobortis. Interdum adipiscing
				gravida odio porttitor sem non mi integer non faucibus ornare mi ut
				ante amet placerat aliquet. Volutpat eu sed ante lacinia sapien
				lorem accumsan varius montes viverra nibh in adipiscing blandit
				tempus accumsan.</p>

			<!-- Lists -->
			<h3>Lists</h3>
			<div class="row">
				<div class="col-6 col-12-small">

					<h4>Unordered</h4>
					<ul>
						<li>Dolor etiam magna etiam.</li>
						<li>Sagittis lorem eleifend.</li>
						<li>Felis dolore viverra.</li>
					</ul>

					<h4>Alternate</h4>
					<ul class="alt">
						<li>Dolor etiam magna etiam.</li>
						<li>Sagittis lorem eleifend.</li>
						<li>Felis feugiat viverra.</li>
					</ul>

				</div>
				<div class="col-6 col-12-small">

					<h4>Ordered</h4>
					<ol>
						<li>Dolor etiam magna etiam.</li>
						<li>Etiam vel lorem sed viverra.</li>
						<li>Felis dolore viverra.</li>
						<li>Dolor etiam magna etiam.</li>
						<li>Etiam vel lorem sed viverra.</li>
						<li>Felis dolore viverra.</li>
					</ol>

					<h4>Icons</h4>
					<ul class="icons">
						<li><a href="#" class="icon brands fa-twitter"><span
								class="label">Twitter</span></a></li>
						<li><a href="#" class="icon brands fa-facebook-f"><span
								class="label">Facebook</span></a></li>
						<li><a href="#" class="icon brands fa-instagram"><span
								class="label">Instagram</span></a></li>
						<li><a href="#" class="icon brands fa-github"><span
								class="label">Github</span></a></li>
						<li><a href="#" class="icon brands fa-dribbble"><span
								class="label">Dribbble</span></a></li>
						<li><a href="#" class="icon brands fa-tumblr"><span
								class="label">Tumblr</span></a></li>
					</ul>

				</div>
			</div>
			<h4>Definition</h4>
			<dl>
				<dt>Item1</dt>
				<dd>
					<p>Lorem ipsum dolor vestibulum ante ipsum primis in faucibus
						vestibulum. Blandit adipiscing eu felis iaculis volutpat ac
						adipiscing accumsan eu faucibus. Integer ac pellentesque praesent.
						Lorem ipsum dolor.</p>
				</dd>
				<dt>Item2</dt>
				<dd>
					<p>Lorem ipsum dolor vestibulum ante ipsum primis in faucibus
						vestibulum. Blandit adipiscing eu felis iaculis volutpat ac
						adipiscing accumsan eu faucibus. Integer ac pellentesque praesent.
						Lorem ipsum dolor.</p>
				</dd>
				<dt>Item3</dt>
				<dd>
					<p>Lorem ipsum dolor vestibulum ante ipsum primis in faucibus
						vestibulum. Blandit adipiscing eu felis iaculis volutpat ac
						adipiscing accumsan eu faucibus. Integer ac pellentesque praesent.
						Lorem ipsum dolor.</p>
				</dd>
			</dl>

			<!-- Blockquote -->
			<h3>Blockquote</h3>
			<blockquote>Lorem ipsum dolor vestibulum ante ipsum
				primis in faucibus vestibulum. Blandit adipiscing eu felis iaculis
				volutpat ac adipiscing accumsan eu faucibus. Integer ac pellentesque
				praesent. Lorem ipsum dolor. Lorem ipsum dolor vestibulum ante ipsum
				primis in faucibus vestibulum. Blandit adipiscing eu felis iaculis
				volutpat ac adipiscing accumsan eu faucibus.</blockquote>


			<!-- Box -->
			<h3>Box</h3>
			<div class="box">
				<p>Felis sagittis eget tempus primis in faucibus vestibulum.
					Blandit adipiscing eu felis iaculis volutpat ac adipiscing accumsan
					eu faucibus. Integer ac pellentesque praesent tincidunt felis
					sagittis eget. tempus euismod. Magna sed etiam ante ipsum primis in
					faucibus vestibulum.</p>
			</div>

			<!-- Preformatted Code -->
			<h3>Preformatted</h3>
			<pre>
				<code>
				i = 0;

				while (!deck.isInOrder()) {
				    print 'Iteration ' + i;
				    deck.shuffle();
				    i++;
				}
				
				print 'It took ' + i + ' iterations to sort the deck.';
				</code>
			</pre>
			
			<!-- Badge -->
			<h3>Badge</h3>
			<span class="badge badge-primary">Primary</span>
			<span class="badge badge-secondary">Secondary</span>
			<span class="badge badge-success">Success</span>
			<span class="badge badge-danger">Danger</span>
			<span class="badge badge-warning">Warning</span>
			<span class="badge badge-info">Info</span>
			<hr/>

			<!-- Modal -->
			<h3>Modal</h3>
			<!-- Button trigger modal -->
			<button type="button" class="button primary" data-toggle="modal"
				data-target="#exampleModal">Launch demo modal</button>
			

			<!-- Modal -->
			<div class="modal fade" id="exampleModal" tabindex="-1"
				aria-labelledby="exampleModalLabel" aria-hidden="true">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="exampleModalLabel">Modal title</h5>
							<button type="button" class="close secondary" data-dismiss="modal"
								aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
						</div>
						<div class="modal-body">...</div>
						<div class="modal-footer">
							<button type="button" class="button small secondary"
								data-dismiss="modal">Close</button>
							<button type="button" class="button small primary">Save
								changes</button>
						</div>
					</div>
				</div>
			</div>
			
			
		</div>
	</div>

</div>

<jsp:include page="/layout/sidebar.jsp" />