int main(void)
{
    __asm__ (
        "SVC 0xA"
    );
	
    for (;;);
}
