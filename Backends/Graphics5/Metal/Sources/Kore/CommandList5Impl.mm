#include "pch.h"

#include <Kore/Graphics5/CommandList.h>
#include <Kore/Graphics5/Graphics.h>
#include <Kore/Graphics5/PipelineState.h>
#include <Kore/Graphics5/ConstantBuffer.h>

#import <Metal/Metal.h>

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

using namespace Kore;

id getMetalDevice();
id getMetalEncoder();

Graphics5::CommandList::CommandList() {}

Graphics5::CommandList::~CommandList() {}

void Graphics5::CommandList::begin() {}

void Graphics5::CommandList::end() {}

void Graphics5::CommandList::clear(RenderTarget* renderTarget, uint flags, uint color, float depth, int stencil) {}

void Graphics5::CommandList::renderTargetToFramebufferBarrier(RenderTarget* renderTarget) {}

void Graphics5::CommandList::framebufferToRenderTargetBarrier(RenderTarget* renderTarget) {}

void Graphics5::CommandList::drawIndexedVertices() {
	drawIndexedVertices(0, IndexBuffer5Impl::current->count());
}

void Graphics5::CommandList::drawIndexedVertices(int start, int count) {
	id<MTLRenderCommandEncoder> encoder = getMetalEncoder();

	//[encoder setDepthStencilState:_depthState];
	[encoder drawIndexedPrimitives:MTLPrimitiveTypeTriangle
		indexCount:count indexType:MTLIndexTypeUInt32
		indexBuffer:IndexBuffer5Impl::current->mtlBuffer
		indexBufferOffset:start + IndexBuffer5Impl::current->offset()];
}

void Graphics5::CommandList::viewport(int x, int y, int width, int height) {
	// TODO
	// id <MTLRenderCommandEncoder> encoder = getMetalEncoder();
	// MTLViewport viewport;
	// viewport.originX=x;
	// viewport.originY=y;
	// viewport.width=width;
	// viewport.height=height;
	// encoder.setViewport(viewport);
}

void Graphics5::CommandList::scissor(int x, int y, int width, int height) {}

void Graphics5::CommandList::disableScissor() {}

void Graphics5::CommandList::setPipeline(PipelineState* pipeline) {
	pipeline->_set();
}

void Graphics5::CommandList::setVertexBuffers(VertexBuffer** buffers, int* offsets, int count) {
	buffers[0]->_set(0);
}

void Graphics5::CommandList::setIndexBuffer(IndexBuffer& buffer) {
	buffer._set();
}

// void restoreRenderTarget();

void Graphics5::CommandList::setRenderTargets(RenderTarget** targets, int count) {}

void Graphics5::CommandList::upload(IndexBuffer* buffer) {}

void Graphics5::CommandList::upload(VertexBuffer* buffer) {}

void Graphics5::CommandList::upload(Texture* texture) {}

void Graphics5::CommandList::executeAndWait() {}

void Graphics5::CommandList::setPipelineLayout() {}

void Graphics5::CommandList::setVertexConstantBuffer(ConstantBuffer* buffer, int offset) {
	id<MTLRenderCommandEncoder> encoder = getMetalEncoder();
	[encoder setVertexBuffer:buffer->_buffer offset:offset atIndex:1];
}

void Graphics5::CommandList::setFragmentConstantBuffer(ConstantBuffer* buffer, int offset) {
	id<MTLRenderCommandEncoder> encoder = getMetalEncoder();
	[encoder setFragmentBuffer:buffer->_buffer offset:offset atIndex:0];
}

void Graphics5::CommandList::renderTargetToTextureBarrier(RenderTarget* renderTarget) {}

void Graphics5::CommandList::textureToRenderTargetBarrier(RenderTarget* renderTarget) {}
