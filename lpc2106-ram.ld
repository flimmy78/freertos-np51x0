MEMORY 
{
	flash	: ORIGIN = 0x80050020, LENGTH = 1728K
	ram	: ORIGIN = 0x00000000, LENGTH = 2M
}

/* define beginning and ending of stack */
__stack_end__ = ORIGIN(ram)+LENGTH(ram) - 4;

SECTIONS 
{
	. = 0;
	startup : { *(.startup)} >ram

	prog : 
	{
		*(.text)
		*(.rodata)
		*(.rodata*)
		*(.glue_7)
		*(.glue_7t)
	} >ram

	.ARM.exidx :
	{
		__exidx_start = .;
		*(.ARM.exidx* .gnu.linkonce.armexidx.*)
		__exidx_end = .;
	} >ram

	. = ALIGN(4);
	__end_of_text__ = .;

	.data : 
	{
		__data_beg__ = .;
		*(.data)
		__data_end__ = .;
	} >ram

	. = ALIGN(16);
	.netbuf(NOLOAD) :
	{
		*(.nbuf) 
	} >ram

	.bss : 
	{
		__bss_beg__ = .;
		*(.bss)
	} >ram

	. = ALIGN(4);
	.eh_frame :
	{
		 KEEP (*(.eh_frame))
	} > ram
	
	/* Align here to ensure that the .bss section occupies space up to
	_end.  Align after .bss to ensure correct alignment even if the
	.bss section disappears because there are no input sections.  */
	. = ALIGN(32 / 8);
}
	. = ALIGN(32 / 8);
	_end = .;
	_bss_end__ = . ; __bss_end__ = . ; __end__ = . ;
	PROVIDE (end = .);
