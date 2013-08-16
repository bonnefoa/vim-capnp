" Vim syntax file
" Language:     Cap'n Proto
" Maintainer:   Anthonin Bonnefoy <anthonin.bonnefoy@gmail.com>

if exists("b:current_syntax")
        finish
endif

syn case match

" Cpnp id declaration
syn match cnpnId /@0x\w\+/ nextgroup=cpnpBlockBegin skipwhite

hi def link cnpnId Constant

" Cpnp keywords
syn keyword cpnpKeywords using annotation

hi def link cpnpKeywords Keyword

" Cpnp block structure
syn keyword cpnpBlockInit struct union enum interface nextgroup=cpnpBlockName skipwhite
syn match cpnpBlockName /\w\+/ nextgroup=cpnpBlock,cpnpId skipwhite contained
syn region cpnpBlock start="{" end="}" contains=@cpnpBlockGroup

hi def link cpnpBlockInit Keyword
hi def link cpnpBlockName Function

" Possible groups in block
syn cluster cpnpBlockGroup contains=cpnpFieldName,cpnpComment,cpnpBlockInit,cpnpBlockEnd

" Parameter block
syn region cpnpParameter start="(" end=")" nextgroup=cpnpParameterType skipwhite
syn match cpnpParameterName /\w\+\s*:/me=e-1 containedin=cpnpParameter nextgroup=cpnpParameterType skipwhite
syn match cpnpParameterType /:\s*\w\+/hs=s+1 skipwhite
syn cluster cpnpParameterGroup contains=cpnpParameterName

hi def link cpnpParameterName Identifier
hi def link cpnpParameterType Type

" Field declaration in block
syn match cpnpFieldName /\w\+\s*@/me=e-1 nextgroup=cpnpFieldAnnotation skipwhite contained
syn match cpnpFieldAnnotation /@\d\+\s*(/me=e-1 contained nextgroup=cpnpParameter skipwhite
syn match cpnpFieldAnnotation /@\d\+\s*\:/he=e-1 contained nextgroup=cpnpFieldType,cpnpImport skipwhite
syn match cpnpFieldAnnotation /@\d\+\s*\;/he=e-1 contained nextgroup=@cpnpBlockGroup skipwhite skipempty
syn match cpnpFieldType /\w\+\s*;/he=e-1 contained nextgroup=@cpnpBlockGroup skipwhite skipempty
syn match cpnpFieldType /List(\w\+)\s*;/he=e-1 contained nextgroup=@cpnpBlockGroup skipwhite skipempty

hi def link cpnpFieldName Identifier
hi def link cpnpFieldAnnotation Special
hi def link cpnpFieldType Type

" Import statetements
syn keyword cpnpImport import nextgroup=cpnpImportValue skipwhite
syn match cpnpImportValue /"\(\w\|\.\)\+"\(\.\w\+\)\?;/he=e-1 contained

hi def link cpnpImport Keyword
hi def link cpnpImportValue Special

" Constants
syn keyword cpnpConst const nextgroup=cpnpConstName skipwhite
syn match cpnpConstName /\w\+\s*:/he=e-1 contained nextgroup=cpnpConstValue
syn match cpnpConstValue /\w\+\s*:/he=e-1 contained nextgroup=cpnpConstValue

hi def link cpnpConst Keyword
hi def link cpnpConstName Constant

" String
syn region cpnpString start=+"+ end=+"+

hi def link cpnpString String

" Comments
syn match cpnpComment /#.*/ nextgroup=@cpnpBlockGroup skipwhite skipempty

hi def link cpnpComment Comment

" Built in types
syn keyword cpnpBuiltinTypes Void
syn keyword cpnpBuiltinTypes Bool
syn keyword cpnpBuiltinTypes Int8 Int16 Int32 Int64
syn keyword cpnpBuiltinTypes UInt8 UInt16 UInt32 UInt64
syn keyword cpnpBuiltinTypes Float32 Float64
syn keyword cpnpBuiltinTypes Text Data
syn keyword cpnpBuiltinTypes List

hi def link cpnpBuiltinTypes Type

let b:current_syntax = "capnp"
